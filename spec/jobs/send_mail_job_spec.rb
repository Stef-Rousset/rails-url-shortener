require 'rails_helper'
require 'sidekiq/testing'

RSpec.describe SendMail, type: :job do
  before(:each) do
    @user = create(:user1)
    @source = create(:source_one)
    @user.sources << @source
  end

  it 'sends an email when performed now' do
    # SendMail.perform_now
    # expect(ActionMailer::Base.deliveries).to be_present
    # ActionMailer::Base.deliveries is an array which stores emails in test environment
    expect { SendMail.perform_now }.to change { ActionMailer::Base.deliveries.count }.by(1)
  end

  it 'enqueues a job when performed later' do
    # add in rails_helper 'ActiveJob::Base.queue_adapter = :test' for this test
    Sidekiq::Testing.fake! do
      expect { SendMail.perform_later }.to have_enqueued_job(described_class).on_queue('default')
    end
  end
end
