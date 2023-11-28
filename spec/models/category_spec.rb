require 'rails_helper'

RSpec.describe Category, type: :model do
  before(:example) do
    @user = create(:user1)
  end

  it 'is invalid if name is absent' do
    cate = Category.new(name: '', user_id: @user.id )
    expect(cate).not_to be_valid
  end
  it 'is valid if name and user_id are present' do
    cate = Category.new(name: 'Santé', user_id: @user.id )
    expect(cate).to be_valid
  end

  it 'is valid if user_id is absent' do
    cate = Category.new(name: 'Santé')
    expect(cate).to be_valid
  end

  it 'capitalizes the name' do
    cate = Category.create!(name: 'travail')
    expect(cate.name).to eq('Travail')
  end
 end
