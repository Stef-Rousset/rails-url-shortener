require 'rails_helper'

RSpec.describe Category, type: :model do
  before(:example) do
    @user = create(:user1)
  end

  context 'name presence' do
    before do
      Category.skip_callback(:validation, :before, :capitalize)
    end

    it 'is invalid if name is absent' do
      cate = Category.new(name: '', user_id: @user.id)
      expect(cate).not_to be_valid
    end
  end

  it 'is valid if name and user_id are present' do
    cate = Category.new(name: 'Santé', user_id: @user.id)
    expect(cate).to be_valid
  end

  it 'is valid if user_id is absent' do
    cate = Category.new(name: 'Santé')
    expect(cate).to be_valid
  end

  it 'capitalizes the name' do
    cate = Category.create(name: 'travail du jour')
    expect(cate.name).to eq('Travail du jour')
  end

  it 'is invalid if name not unique for the user' do
    cate1 = create(:category, user: @user)
    cate2 = Category.new(name: cate1.name, user_id: @user.id)
    expect(cate2).not_to be_valid
  end

  it 'updates category_id to nil when category is destroyed' do
    cate = create(:category, user: @user)
    acc = create(:account, user: @user)
    tr = create(:transaction1, category: cate, account: acc)
    expect(tr.category_id).to eq(cate.id)
    cate.destroy
    tr.reload
    expect(tr.category_id).to eq(nil)
  end
 end
