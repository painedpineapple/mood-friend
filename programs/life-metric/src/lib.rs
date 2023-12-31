pub mod state;

use anchor_lang::prelude::*;
use state::*;

declare_id!("moiffJUWfXvFu11Yzo3CxDEuu84UmCiEct5gDY6R3rj");

pub const LIFE_METRIC_PDA_SEED: &str = "life_metric";

#[program]
pub mod life_metric {
    use super::*;

    pub fn initialize(ctx: Context<Initialize>) -> Result<()> {
        let base_account = &mut ctx.accounts.base_account;
        base_account.total_life_metrics = 0;
        Ok(())
    }

    pub fn create_life_metric(
        ctx: Context<CreateLifeMetric>,
        salt: String,
        ciphertext: String,
    ) -> Result<()> {
        let life_metric = &mut ctx.accounts.life_metric;
        let base_account = &mut ctx.accounts.base_account;
        let user = &mut ctx.accounts.user;

        life_metric.salt = salt;
        life_metric.ciphertext = ciphertext;
        life_metric.initializer = user.key();

        base_account.total_life_metrics += 1;

        Ok(())
    }
}

#[derive(Accounts)]
pub struct CreateLifeMetric<'info> {
    // TODO: Calculate true size
    #[account(init, payer = user, space = LifeMetric::LEN, seeds = [
			LIFE_METRIC_PDA_SEED.as_ref(),
			user.key().as_ref(),
			base_account.key().as_ref(),
            &base_account.total_life_metrics.to_le_bytes()
		], bump)]
    pub life_metric: Account<'info, LifeMetric>,
    #[account(mut)]
    pub base_account: Account<'info, BaseAccount>,
    #[account(mut)]
    pub user: Signer<'info>,
    pub system_program: Program<'info, System>,
}

#[derive(Accounts)]
pub struct Initialize<'info> {
    // TODO: Calculate true size
    #[account(init, payer = user, space = BaseAccount::LEN, seeds = [
			LIFE_METRIC_PDA_SEED.as_ref(),
			user.key().as_ref(),
		], bump)]
    pub base_account: Account<'info, BaseAccount>,
    #[account(mut)]
    pub user: Signer<'info>,
    pub system_program: Program<'info, System>,
}
