mod pre_implemented;

use std::ptr::NonNull;

pub struct Node<T> {
    data: T,
    prev: Option<NonNull<Node<T>>>,
    next: Option<NonNull<Node<T>>>,
}

pub struct LinkedList<T> {
    front: Option<NonNull<Node<T>>>,
    back: Option<NonNull<Node<T>>>,
    len: usize,
}

pub struct Cursor<'a, T> {
    list: &'a mut LinkedList<T>,
    pos: Option<NonNull<Node<T>>>,
}

pub struct Iter<'a, T> {
    next: &'a Option<NonNull<Node<T>>>,
}

impl<T> Node<T> {
    pub fn new(data: T) -> NonNull<Self> {
        unsafe {
            NonNull::new_unchecked(Box::into_raw(Box::new(Self {
                data,
                prev: None,
                next: None,
            })))
        }
    }

    pub fn link_prev(&mut self, mut prev: NonNull<Node<T>>) {
        let node = self as *mut Node<T>;

        self.prev = Some(prev);
        unsafe {
            prev.as_mut().next = NonNull::new(node);
        }
    }

    pub fn link_next(&mut self, mut next: NonNull<Node<T>>) {
        let node = self as *mut Node<T>;

        self.next = Some(next);
        unsafe {
            next.as_mut().prev = NonNull::new(node);
        }
    }
}

impl<T> LinkedList<T> {
    pub fn new() -> Self {
        Self {
            front: None,
            back: None,
            len: 0,
        }
    }

    pub fn is_empty(&self) -> bool {
        self.len == 0
    }

    pub fn len(&self) -> usize {
        self.len
    }

    pub fn cursor_front(&mut self) -> Cursor<'_, T> {
        Cursor {
            pos: self.front,
            list: self,
        }
    }

    pub fn cursor_back(&mut self) -> Cursor<'_, T> {
        Cursor {
            pos: self.back,
            list: self,
        }
    }

    pub fn iter(&self) -> Iter<'_, T> {
        Iter { next: &self.front }
    }
}

impl<T> Drop for LinkedList<T> {
    fn drop(&mut self) {
        while !self.is_empty() {
            self.pop_front();
        }
    }
}

unsafe impl<T: Send> Send for LinkedList<T> {}
unsafe impl<T: Sync> Sync for LinkedList<T> {}

impl<T> Cursor<'_, T> {
    pub fn peek_mut(&mut self) -> Option<&mut T> {
        unsafe { self.pos.map(|node| &mut (*node.as_ptr()).data) }
    }

    #[allow(clippy::should_implement_trait)]
    pub fn next(&mut self) -> Option<&mut T> {
        match self.pos {
            Some(node) => {
                self.pos = unsafe { node.as_ref().next };

                self.peek_mut()
            }
            None => None,
        }
    }

    pub fn prev(&mut self) -> Option<&mut T> {
        match self.pos {
            Some(node) => {
                self.pos = unsafe { node.as_ref().prev };

                self.peek_mut()
            }
            None => None,
        }
    }

    pub fn take(&mut self) -> Option<T> {
        match self.pos {
            Some(mut node) => unsafe {
                let prev = node.as_mut().prev;
                let next = node.as_mut().next;

                self.pos = next.or(prev);
                self.list.len -= 1;
                match prev {
                    Some(mut prev) => prev.as_mut().next = next,
                    None => self.list.front = next,
                }
                match next {
                    Some(mut next) => next.as_mut().prev = prev,
                    None => self.list.back = prev,
                }

                Some(Box::from_raw(node.as_ptr()).data)
            },
            None => None,
        }
    }

    pub fn insert_after(&mut self, data: T) {
        match self.pos {
            Some(mut curr) => {
                let mut node = Node::new(data);

                unsafe {
                    match curr.as_mut().next {
                        Some(next) => node.as_mut().link_next(next),
                        None => self.list.back = Some(node),
                    }
                    node.as_mut().link_prev(curr);
                }
            }
            None => self.insert_empty(data),
        }
        self.list.len += 1;
    }

    pub fn insert_before(&mut self, data: T) {
        match self.pos {
            Some(mut curr) => {
                let mut node = Node::new(data);

                unsafe {
                    match curr.as_mut().prev {
                        Some(prev) => node.as_mut().link_prev(prev),
                        None => self.list.front = Some(node),
                    }
                    node.as_mut().link_next(curr);
                }
            }
            None => self.insert_empty(data),
        }
        self.list.len += 1;
    }

    pub fn insert_empty(&mut self, data: T) {
        let node = Node::new(data);

        self.list.front = Some(node);
        self.list.back = Some(node);
        self.pos = Some(node);
    }
}

impl<'a, T> Iterator for Iter<'a, T> {
    type Item = &'a T;

    fn next(&mut self) -> Option<&'a T> {
        self.next.map(|next| unsafe {
            let node = &*next.as_ptr();
            self.next = &node.next;

            &node.data
        })
    }
}
