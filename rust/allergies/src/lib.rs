pub struct Allergies {
    allergens: Vec<Allergen>,
}

#[derive(Clone, Debug, PartialEq)]
pub enum Allergen {
    Eggs,
    Peanuts,
    Shellfish,
    Strawberries,
    Tomatoes,
    Chocolate,
    Pollen,
    Cats,
}

impl Allergies {
    pub fn new(score: u32) -> Self {
        let mut allergens = vec![];

        for i in 0..8 {
            if score & (1 << i) > 0 {
                allergens.push(match i {
                    0 => Allergen::Eggs,
                    1 => Allergen::Peanuts,
                    2 => Allergen::Shellfish,
                    3 => Allergen::Strawberries,
                    4 => Allergen::Tomatoes,
                    5 => Allergen::Chocolate,
                    6 => Allergen::Pollen,
                    _ => Allergen::Cats,
                });
            }
        }

        Self { allergens }
    }

    pub fn is_allergic_to(&self, allergen: &Allergen) -> bool {
        self.allergens.contains(allergen)
    }

    pub fn allergies(&self) -> Vec<Allergen> {
        self.allergens.clone()
    }
}
