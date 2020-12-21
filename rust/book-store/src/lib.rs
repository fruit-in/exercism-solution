const DISCOUNT_PRICE: [u32; 6] = [0, 800, 1520, 2160, 2560, 3000];

pub fn lowest_price(books: &[u32]) -> u32 {
    let mut counter = vec![(0, 1), (0, 2), (0, 3), (0, 4), (0, 5)];

    for book in books {
        counter[*book as usize - 1].0 += 1;
    }
    counter.sort_unstable_by(|(a, _), (b, _)| b.cmp(a));

    lowest_price_counter(counter)
}

pub fn lowest_price_counter(counter: Vec<(u32, u8)>) -> u32 {
    let mut price = counter.iter().map(|(c, _)| c).sum::<u32>() * 800;

    for i in 2..=counter.iter().filter(|&&(c, _)| c > 0).count() {
        let mut new_counter = counter.clone();

        for j in 0..i {
            new_counter[j].0 -= 1;
        }
        new_counter.sort_unstable_by(|(a, _), (b, _)| b.cmp(a));

        price = price.min(DISCOUNT_PRICE[i] + lowest_price_counter(new_counter));
    }

    price
}
