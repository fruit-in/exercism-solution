use std::cmp::Ordering;
use std::str::FromStr;

#[derive(PartialEq)]
pub enum Suit {
    Clubs,
    Diamonds,
    Hearts,
    Spades,
}

pub struct Card {
    number: u8,
    suit: Suit,
}

impl FromStr for Card {
    type Err = ();

    fn from_str(s: &str) -> Result<Self, Self::Err> {
        let s = s.as_bytes();
        let number = match s[0] {
            b'A' => 14,
            b'K' => 13,
            b'Q' => 12,
            b'J' => 11,
            b'1' if s[1] == b'0' => 10,
            b'2'..=b'9' => s[0] - 48,
            _ => return Err(()),
        };
        let suit = match s.last() {
            Some(&b'C') => Suit::Clubs,
            Some(&b'D') => Suit::Diamonds,
            Some(&b'H') => Suit::Hearts,
            Some(&b'S') => Suit::Spades,
            _ => return Err(()),
        };

        Ok(Card { number, suit })
    }
}

pub enum Hands {
    StraightFlush(u8),
    FourOfAKind(u8, u8),
    FullHouse(u8, u8),
    Flush(u8, u8, u8, u8, u8),
    Straight(u8),
    ThreeOfAKind(u8, u8, u8),
    TwoPair(u8, u8, u8),
    OnePair(u8, u8, u8, u8),
    HighCard(u8, u8, u8, u8, u8),
}

impl Hands {
    pub fn new(mut cards: Vec<Card>) -> Self {
        cards.sort_unstable_by(|a, b| b.number.cmp(&a.number));

        if let Ok(hands) = Self::to_straight_flush(&cards) {
            hands
        } else if let Ok(hands) = Self::to_four_of_a_kind(&cards) {
            hands
        } else if let Ok(hands) = Self::to_full_house(&cards) {
            hands
        } else if let Ok(hands) = Self::to_flush(&cards) {
            hands
        } else if let Ok(hands) = Self::to_straight(&cards) {
            hands
        } else if let Ok(hands) = Self::to_three_of_a_kind(&cards) {
            hands
        } else if let Ok(hands) = Self::to_two_pair(&cards) {
            hands
        } else if let Ok(hands) = Self::to_one_pair(&cards) {
            hands
        } else {
            Self::to_high_card(&cards).unwrap()
        }
    }

    pub fn to_straight_flush(cards: &Vec<Card>) -> Result<Self, ()> {
        Self::to_flush(cards)?;

        match Self::to_straight(cards) {
            Ok(Hands::Straight(number)) => Ok(Hands::StraightFlush(number)),
            _ => Err(()),
        }
    }

    pub fn to_four_of_a_kind(cards: &Vec<Card>) -> Result<Self, ()> {
        let numbers = cards.iter().map(|card| card.number).collect::<Vec<_>>();

        if (1..4).all(|i| numbers[i] == numbers[i - 1]) {
            Ok(Hands::FourOfAKind(numbers[0], numbers[4]))
        } else if (2..5).all(|i| numbers[i] == numbers[i - 1]) {
            Ok(Hands::FourOfAKind(numbers[1], numbers[0]))
        } else {
            Err(())
        }
    }

    pub fn to_full_house(cards: &Vec<Card>) -> Result<Self, ()> {
        let numbers = cards.iter().map(|card| card.number).collect::<Vec<_>>();

        if [1, 2, 4].iter().all(|&i| numbers[i] == numbers[i - 1]) {
            Ok(Hands::FullHouse(numbers[0], numbers[3]))
        } else if [1, 3, 4].iter().all(|&i| numbers[i] == numbers[i - 1]) {
            Ok(Hands::FullHouse(numbers[2], numbers[0]))
        } else {
            Err(())
        }
    }

    pub fn to_flush(cards: &Vec<Card>) -> Result<Self, ()> {
        let numbers = cards.iter().map(|card| card.number).collect::<Vec<_>>();

        if (1..5).all(|i| cards[i].suit == cards[i - 1].suit) {
            Ok(Hands::Flush(
                numbers[0], numbers[1], numbers[2], numbers[3], numbers[4],
            ))
        } else {
            Err(())
        }
    }

    pub fn to_straight(cards: &Vec<Card>) -> Result<Self, ()> {
        let mut numbers = cards.iter().map(|card| card.number).collect::<Vec<_>>();

        if (1..5).all(|i| numbers[i] == numbers[i - 1] - 1) {
            return Ok(Hands::Straight(numbers[0]));
        }

        for i in 0..5 {
            if numbers[i] == 14 {
                numbers[i] = 1;
            }
        }
        numbers.sort_unstable_by(|a, b| b.cmp(a));

        if (1..5).all(|i| numbers[i] == numbers[i - 1] - 1) {
            return Ok(Hands::Straight(numbers[0]));
        } else {
            Err(())
        }
    }

    pub fn to_three_of_a_kind(cards: &Vec<Card>) -> Result<Self, ()> {
        let numbers = cards.iter().map(|card| card.number).collect::<Vec<_>>();

        if (1..3).all(|i| numbers[i] == numbers[i - 1]) {
            Ok(Hands::ThreeOfAKind(numbers[0], numbers[3], numbers[4]))
        } else if (2..4).all(|i| numbers[i] == numbers[i - 1]) {
            Ok(Hands::ThreeOfAKind(numbers[1], numbers[0], numbers[4]))
        } else if (3..5).all(|i| numbers[i] == numbers[i - 1]) {
            Ok(Hands::ThreeOfAKind(numbers[2], numbers[0], numbers[1]))
        } else {
            Err(())
        }
    }

    pub fn to_two_pair(cards: &Vec<Card>) -> Result<Self, ()> {
        let numbers = cards.iter().map(|card| card.number).collect::<Vec<_>>();

        if numbers[0] == numbers[1] && numbers[2] == numbers[3] {
            Ok(Hands::TwoPair(numbers[0], numbers[2], numbers[4]))
        } else if numbers[0] == numbers[1] && numbers[3] == numbers[4] {
            Ok(Hands::TwoPair(numbers[0], numbers[3], numbers[2]))
        } else if numbers[1] == numbers[2] && numbers[3] == numbers[4] {
            Ok(Hands::TwoPair(numbers[1], numbers[3], numbers[0]))
        } else {
            Err(())
        }
    }

    pub fn to_one_pair(cards: &Vec<Card>) -> Result<Self, ()> {
        let numbers = cards.iter().map(|card| card.number).collect::<Vec<_>>();

        if numbers[0] == numbers[1] {
            Ok(Hands::OnePair(
                numbers[0], numbers[2], numbers[3], numbers[4],
            ))
        } else if numbers[1] == numbers[2] {
            Ok(Hands::OnePair(
                numbers[1], numbers[0], numbers[3], numbers[4],
            ))
        } else if numbers[2] == numbers[3] {
            Ok(Hands::OnePair(
                numbers[2], numbers[0], numbers[1], numbers[4],
            ))
        } else if numbers[3] == numbers[4] {
            Ok(Hands::OnePair(
                numbers[3], numbers[0], numbers[1], numbers[2],
            ))
        } else {
            Err(())
        }
    }

    pub fn to_high_card(cards: &Vec<Card>) -> Result<Self, ()> {
        let numbers = cards.iter().map(|card| card.number).collect::<Vec<_>>();

        Ok(Hands::HighCard(
            numbers[0], numbers[1], numbers[2], numbers[3], numbers[4],
        ))
    }

    pub fn to_vec(&self) -> Vec<u8> {
        match *self {
            Hands::StraightFlush(a) => vec![9, a],
            Hands::FourOfAKind(a, b) => vec![8, a, b],
            Hands::FullHouse(a, b) => vec![7, a, b],
            Hands::Flush(a, b, c, d, e) => vec![6, a, b, c, d, e],
            Hands::Straight(a) => vec![5, a],
            Hands::ThreeOfAKind(a, b, c) => vec![4, a, b, c],
            Hands::TwoPair(a, b, c) => vec![3, a, b, c],
            Hands::OnePair(a, b, c, d) => vec![2, a, b, c, d],
            Hands::HighCard(a, b, c, d, e) => vec![1, a, b, c, d, e],
        }
    }
}

impl FromStr for Hands {
    type Err = ();

    fn from_str(s: &str) -> Result<Self, Self::Err> {
        Ok(Hands::new(
            s.split(' ').map(|c| Card::from_str(c).unwrap()).collect(),
        ))
    }
}

impl PartialEq for Hands {
    fn eq(&self, other: &Self) -> bool {
        self.to_vec() == other.to_vec()
    }
}

impl PartialOrd for Hands {
    fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
        self.to_vec().partial_cmp(&other.to_vec())
    }
}

pub fn winning_hands<'a>(hands: &[&'a str]) -> Option<Vec<&'a str>> {
    let mut hands = hands.to_vec();
    let mut ret = vec![];

    hands.sort_unstable_by(|a, b| {
        Hands::from_str(a)
            .unwrap()
            .partial_cmp(&Hands::from_str(b).unwrap())
            .unwrap()
    });

    while let Some(s0) = hands.pop() {
        if let Some(&s1) = ret.last() {
            if Hands::from_str(s0).unwrap() != Hands::from_str(s1).unwrap() {
                break;
            }
        }
        ret.push(s0);
    }

    if ret.is_empty() {
        None
    } else {
        Some(ret)
    }
}
