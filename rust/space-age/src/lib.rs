#[derive(Debug)]
pub struct Duration(u64);

impl From<u64> for Duration {
    fn from(s: u64) -> Self {
        Self(s)
    }
}

pub trait Planet {
    fn ratio() -> f64;

    fn years_during(d: &Duration) -> f64 {
        d.0 as f64 / 31_557_600. / Self::ratio()
    }
}

pub struct Mercury;
pub struct Venus;
pub struct Earth;
pub struct Mars;
pub struct Jupiter;
pub struct Saturn;
pub struct Uranus;
pub struct Neptune;

impl Planet for Mercury {
    fn ratio() -> f64 {
        0.2408467
    }
}
impl Planet for Venus {
    fn ratio() -> f64 {
        0.61519726
    }
}
impl Planet for Earth {
    fn ratio() -> f64 {
        1.0
    }
}
impl Planet for Mars {
    fn ratio() -> f64 {
        1.8808158
    }
}
impl Planet for Jupiter {
    fn ratio() -> f64 {
        11.862615
    }
}
impl Planet for Saturn {
    fn ratio() -> f64 {
        29.447498
    }
}
impl Planet for Uranus {
    fn ratio() -> f64 {
        84.016846
    }
}
impl Planet for Neptune {
    fn ratio() -> f64 {
        164.79132
    }
}
