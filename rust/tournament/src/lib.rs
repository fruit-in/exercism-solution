use std::collections::HashMap;

pub fn tally(match_results: &str) -> String {
    let mut hash = HashMap::new();
    let mut table = vec!["Team                           | MP |  W |  D |  L |  P".to_string()];

    for line in match_results.lines() {
        let result = line.split(';').collect::<Vec<_>>();

        hash.entry(result[0]).or_insert(vec![0; 4])[0] += 1;
        hash.entry(result[1]).or_insert(vec![0; 4])[0] += 1;
        match result[2] {
            "win" => {
                hash.entry(result[0]).or_insert(vec![0; 4])[1] += 1;
                hash.entry(result[1]).or_insert(vec![0; 4])[3] += 1;
            }
            "loss" => {
                hash.entry(result[0]).or_insert(vec![0; 4])[3] += 1;
                hash.entry(result[1]).or_insert(vec![0; 4])[1] += 1;
            }
            _ => {
                hash.entry(result[0]).or_insert(vec![0; 4])[2] += 1;
                hash.entry(result[1]).or_insert(vec![0; 4])[2] += 1;
            }
        }
    }

    let mut teams = hash.iter().collect::<Vec<_>>();

    teams.sort_unstable();
    teams.sort_by_key(|(_, result)| -(result[1] * 3 + result[2]));

    for (name, result) in teams {
        table.push(format!(
            "{:<30} | {:>2} | {:>2} | {:>2} | {:>2} | {:>2}",
            name,
            result[0],
            result[1],
            result[2],
            result[3],
            result[1] * 3 + result[2]
        ));
    }

    table.join("\n")
}
