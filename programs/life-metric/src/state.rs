use anchor_lang::prelude::*;

const DISCRIMINATOR_LENGTH: usize = 8;

// #[derive(AnchorDeserialize, AnchorSerialize, Clone, Debug, PartialEq)]
// pub enum HighMood {
//     Manic,
//     HypoManic,
//     Elevated,
//     Neutral,
// }

// #[derive(AnchorDeserialize, AnchorSerialize, Clone, Debug, PartialEq)]
// pub enum LowMood {
//     DeeplyDepressed,
//     Depressed,
//     Sad,
//     Neutral,
// }

#[account]
pub struct LifeMetric {
    pub initializer: Pubkey,
    pub salt: String,
    pub ciphertext: String,
    // pub date: u64,
    // pub high_mood: HighMood,
    // pub low_mood: LowMood,
}

impl LifeMetric {
    pub const LEN: usize = (DISCRIMINATOR_LENGTH +
        32 + // initializer
        2 + // salt
        // data
        256)
        * 2;
}

#[account]
pub struct BaseAccount {
    pub total_life_metrics: u32,
}

impl BaseAccount {
    pub const LEN: usize = (
        DISCRIMINATOR_LENGTH + 4
        // total_life_metrics
    ) * 2; // reserve 2x space for future additions
}
