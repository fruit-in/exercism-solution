use std::iter::FromIterator;

pub struct Node<T> {
    data: T,
    next: Option<Box<Node<T>>>,
}

pub struct SimpleLinkedList<T> {
    head: Option<Box<Node<T>>>,
}

impl<T> SimpleLinkedList<T> {
    pub fn new() -> Self {
        Self { head: None }
    }

    pub fn is_empty(&self) -> bool {
        self.head.is_none()
    }

    pub fn len(&self) -> usize {
        let mut curr = &self.head;
        let mut len = 0;

        while let Some(node) = curr {
            len += 1;
            curr = &node.next;
        }

        len
    }

    pub fn push(&mut self, _element: T) {
        self.head = Some(Box::new(Node {
            data: _element,
            next: self.head.take(),
        }));
    }

    pub fn pop(&mut self) -> Option<T> {
        match self.head.take() {
            Some(head) => {
                self.head = head.next;
                Some(head.data)
            }
            None => None,
        }
    }

    pub fn peek(&self) -> Option<&T> {
        match &self.head {
            Some(head) => Some(&head.data),
            None => None,
        }
    }

    pub fn rev(mut self) -> SimpleLinkedList<T> {
        let mut rev_list = SimpleLinkedList::new();

        while let Some(elem) = self.pop() {
            rev_list.push(elem);
        }

        rev_list
    }
}

impl<T> FromIterator<T> for SimpleLinkedList<T> {
    fn from_iter<I: IntoIterator<Item = T>>(_iter: I) -> Self {
        let mut list = SimpleLinkedList::new();

        _iter.into_iter().for_each(|elem| list.push(elem));

        list
    }
}

impl<T> Into<Vec<T>> for SimpleLinkedList<T> {
    fn into(self) -> Vec<T> {
        let mut list = self.rev();
        let mut vec = vec![];

        while let Some(elem) = list.pop() {
            vec.push(elem);
        }

        vec
    }
}
