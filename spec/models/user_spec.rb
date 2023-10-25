require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user = create(:user1)
    @source = create(:source_one)
    @user.sources << @source
  end

  it "returns a hash with user's sources news" do
    hash = @user.user_news
    expect(hash.class).to eq(Hash)
    expect(hash.keys).to eq(['lemonde'])
  end
end
