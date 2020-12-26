use std::collections::HashMap;
use std::collections::HashSet;

/// `InputCellID` is a unique identifier for an input cell.
#[derive(Clone, Copy, Debug, PartialEq)]
pub struct InputCellID(usize);
/// `ComputeCellID` is a unique identifier for a compute cell.
/// Values of type `InputCellID` and `ComputeCellID` should not be mutually assignable,
/// demonstrated by the following tests:
///
/// ```compile_fail
/// let mut r = react::Reactor::new();
/// let input: react::ComputeCellID = r.create_input(111);
/// ```
///
/// ```compile_fail
/// let mut r = react::Reactor::new();
/// let input = r.create_input(111);
/// let compute: react::InputCellID = r.create_compute(&[react::CellID::Input(input)], |_| 222).unwrap();
/// ```
#[derive(Clone, Copy, Debug, Eq, Hash, PartialEq)]
pub struct ComputeCellID(usize);
#[derive(Clone, Copy, Debug, Eq, Hash, PartialEq)]
pub struct CallbackID(usize);

#[derive(Clone, Copy, Debug, PartialEq)]
pub enum CellID {
    Input(InputCellID),
    Compute(ComputeCellID),
}

#[derive(Debug, PartialEq)]
pub enum RemoveCallbackError {
    NonexistentCell,
    NonexistentCallback,
}

pub struct InputCell<T> {
    _id: CellID,
    val: T,
    dependents: Vec<ComputeCellID>,
}

impl<T> InputCell<T> {
    pub fn new(id: InputCellID, initial: T) -> Self {
        Self {
            _id: CellID::Input(id),
            val: initial,
            dependents: vec![],
        }
    }
}

pub struct ComputeCell<'a, T> {
    _id: CellID,
    old_val: T,
    val: T,
    dependents: Vec<ComputeCellID>,
    dependencies: Vec<CellID>,
    compute_func: Box<dyn 'a + Fn(&[T]) -> T>,
    callbacks: HashMap<CallbackID, Box<dyn 'a + FnMut(T)>>,
    callbacks_count: usize,
}

impl<'a, T> ComputeCell<'a, T> {
    pub fn new<F>(id: ComputeCellID, vals: &[T], dependencies: &[CellID], compute_func: F) -> Self
    where
        T: Copy,
        F: 'a + Fn(&[T]) -> T,
    {
        let val = compute_func(vals);

        Self {
            _id: CellID::Compute(id),
            old_val: val,
            val,
            dependents: vec![],
            dependencies: dependencies.to_vec(),
            compute_func: Box::new(compute_func),
            callbacks: HashMap::new(),
            callbacks_count: 0,
        }
    }
}

pub struct Reactor<'a, T> {
    input_cells: Vec<InputCell<T>>,
    compute_cells: Vec<ComputeCell<'a, T>>,
}

impl<'a, T: Copy + PartialEq> Reactor<'a, T> {
    pub fn new() -> Self {
        Self {
            input_cells: vec![],
            compute_cells: vec![],
        }
    }

    pub fn create_input(&mut self, initial: T) -> InputCellID {
        let id = InputCellID(self.input_cells.len());
        let cell = InputCell::new(id, initial);

        self.input_cells.push(cell);

        id
    }

    pub fn create_compute<F>(
        &mut self,
        dependencies: &[CellID],
        compute_func: F,
    ) -> Result<ComputeCellID, CellID>
    where
        F: 'a + Fn(&[T]) -> T,
    {
        let compute_id = ComputeCellID(self.compute_cells.len());
        let mut vals = vec![];

        for &id in dependencies {
            match id {
                CellID::Input(InputCellID(id)) if self.input_cells.len() > id => {
                    vals.push(self.input_cells[id].val)
                }
                CellID::Compute(ComputeCellID(id)) if self.compute_cells.len() > id => {
                    vals.push(self.compute_cells[id].val)
                }
                _ => return Err(id),
            }
        }

        let cell = ComputeCell::new(compute_id, &vals, dependencies, compute_func);

        self.compute_cells.push(cell);
        for &id in dependencies {
            match id {
                CellID::Input(InputCellID(id)) => self.input_cells[id].dependents.push(compute_id),
                CellID::Compute(ComputeCellID(id)) => {
                    self.compute_cells[id].dependents.push(compute_id)
                }
            }
        }

        Ok(compute_id)
    }

    pub fn value(&self, id: CellID) -> Option<T> {
        match id {
            CellID::Input(InputCellID(id)) => self.input_cells.get(id).map(|cell| cell.val),
            CellID::Compute(ComputeCellID(id)) => self.compute_cells.get(id).map(|cell| cell.val),
        }
    }

    pub fn set_value(&mut self, id: InputCellID, new_value: T) -> bool {
        match self.input_cells.get_mut(id.0) {
            Some(cell) => {
                cell.val = new_value;
                self.update(self.input_cells[id.0].dependents.clone());

                true
            }
            None => false,
        }
    }

    pub fn add_callback<F>(&mut self, id: ComputeCellID, callback: F) -> Option<CallbackID>
    where
        F: 'a + FnMut(T),
    {
        self.compute_cells.get_mut(id.0).map(|cell| {
            let callback_id = CallbackID(cell.callbacks_count);

            cell.callbacks.insert(callback_id, Box::new(callback));
            cell.callbacks_count += 1;

            callback_id
        })
    }

    pub fn remove_callback(
        &mut self,
        cell: ComputeCellID,
        callback: CallbackID,
    ) -> Result<(), RemoveCallbackError> {
        match self.compute_cells.get_mut(cell.0) {
            Some(cell) => match cell.callbacks.remove(&callback) {
                Some(_) => Ok(()),
                None => Err(RemoveCallbackError::NonexistentCallback),
            },
            None => Err(RemoveCallbackError::NonexistentCell),
        }
    }

    pub fn update(&mut self, mut dependents: Vec<ComputeCellID>) {
        let mut callback_cells = vec![];

        while !dependents.is_empty() {
            let mut new_dependents = vec![];

            for compute_id in dependents {
                let mut vals = vec![];

                for id in self.compute_cells[compute_id.0].dependencies.clone() {
                    match id {
                        CellID::Input(InputCellID(id)) => vals.push(self.input_cells[id].val),
                        CellID::Compute(ComputeCellID(id)) => vals.push(self.compute_cells[id].val),
                    }
                }

                self.compute_cells[compute_id.0].val =
                    (self.compute_cells[compute_id.0].compute_func)(&vals);

                if self.compute_cells[compute_id.0].val != self.compute_cells[compute_id.0].old_val
                {
                    new_dependents.append(&mut self.compute_cells[compute_id.0].dependents.clone());
                    callback_cells.push(compute_id);
                }
            }

            dependents = new_dependents;
        }

        self.run_callbacks(callback_cells);
    }

    pub fn run_callbacks(&mut self, ids: Vec<ComputeCellID>) {
        for id in ids.iter().collect::<HashSet<_>>().iter() {
            let val = self.compute_cells[id.0].val;

            for callback in self.compute_cells[id.0].callbacks.values_mut() {
                callback(val);
            }

            self.compute_cells[id.0].val = val;
            self.compute_cells[id.0].old_val = val;
        }
    }
}
