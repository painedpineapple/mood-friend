use anchor_lang::prelude::*;

declare_id!("moiffJUWfXvFu11Yzo3CxDEuu84UmCiEct5gDY6R3rj");

#[program]
pub mod life_metric {
    use super::*;

    pub fn initialize(ctx: Context<Initialize>) -> Result<()> {
        Ok(())
    }
}

#[derive(Accounts)]
pub struct Initialize {}
