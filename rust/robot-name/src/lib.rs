#[macro_use]
extern crate lazy_static;

use rand::Rng;
use std::collections::HashSet;
use std::sync::Mutex;

lazy_static! {
    static ref NAMES: Mutex<HashSet<String>> = Mutex::new(HashSet::new());
}

pub struct Robot(String);

impl Robot {
    pub fn new() -> Self {
        let mut robot = Self("".to_string());

        robot.reset_name();

        robot
    }

    pub fn name(&self) -> &str {
        &self.0
    }

    pub fn reset_name(&mut self) {
        NAMES.lock().unwrap().remove(&self.0);

        let mut rng = rand::thread_rng();

        loop {
            let name = String::from_utf8(vec![
                rng.gen_range(b'A', b'Z' + 1),
                rng.gen_range(b'A', b'Z' + 1),
                rng.gen_range(b'0', b'9' + 1),
                rng.gen_range(b'0', b'9' + 1),
                rng.gen_range(b'0', b'9' + 1),
            ])
            .unwrap();

            if !NAMES.lock().unwrap().contains(&name) {
                self.0 = name.clone();
                NAMES.lock().unwrap().insert(name);
                break;
            }
        }
    }
}
