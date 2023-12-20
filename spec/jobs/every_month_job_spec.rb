require 'rails_helper'
require 'sidekiq/testing'

RSpec.describe EveryMonthJob, type: :job do
  before(:example) do
    @user = create(:user, :normal)
    @account = create(:account, user: @user)
    @planned = create(:planned_transaction, :every_month, account: @account)
    @planned.update_column("start_date", Date.today)
  end

  it 'creates a new transaction when perform now' do
    count = Transaction.where(account_id: @account.id).count
    EveryMonthJob.perform_now
    updated_count = Transaction.where(account_id: @account.id).count
    expect(updated_count).to eq(count + 1)
  end

  it 'enqueues a job with Sidekiq' do
    Sidekiq::Testing.fake! do
      expect { EveryMonthJob.perform_later }.to have_enqueued_job(described_class).on_queue('default')
    end
  end
end
