use rand::Rng;

pub fn private_key(p: u64) -> u64 {
    rand::thread_rng().gen_range(2, p)
}

pub fn public_key(p: u64, g: u64, a: u64) -> u64 {
    if a > 0 {
        let x = public_key(p, g, a / 2);

        return match a % 2 {
            0 => x * x,
            _ => x * x % p * (g % p),
        } % p;
    }

    1
}

pub fn secret(p: u64, b_pub: u64, a: u64) -> u64 {
    public_key(p, b_pub, a)
}
