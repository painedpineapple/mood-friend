use anchor_lang::prelude::*;

declare_id!("mooDiEwJRfno2EaH5PGEfsCWDABb7uHF1DKCdnfwxbB");

#[program]
pub mod moodi {
    use super::*;

    pub fn initialize(ctx: Context<Initialize>) -> Result<()> {
        Ok(())
    }
}

#[derive(Accounts)]
pub struct Initialize {}
