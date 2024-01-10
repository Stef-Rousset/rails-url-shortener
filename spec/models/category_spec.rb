# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  user_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Category, type: :model do
  before(:example) do
    @user = create(:user, :normal)
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

  it 'is invalid if user_id is absent' do
    cate = Category.new(name: 'Santé', user_id: nil)
    expect(cate).not_to be_valid
  end

  it 'is valid if name and user_id are present' do
    cate = Category.new(name: 'Vacances', user_id: @user.id)
    expect(cate).to be_valid
  end

  it 'capitalizes the name and supress spaces' do
    cate = Category.create(name: ' travail du jour ')
    expect(cate.name).to eq('Travail du jour')
  end

  it 'is invalid if name not unique for the user' do
    cate = Category.create(name: 'Vacances', user_id: @user.id)
    cate2 = Category.new(name: cate.name, user_id: @user.id)
    expect(cate2).not_to be_valid
  end

  it 'updates category_id to nil when category is destroyed' do
    cate = Category.create(name: 'Vacances', user_id: @user.id)
    acc = create(:account, user: @user)
    tr = create(:transaction1, category: cate, account: acc)
    pl = create(:planned_transaction, :every_month, category: cate, account: acc)
    expect(tr.category_id).to eq(cate.id)
    expect(pl.category_id).to eq(cate.id)
    cate.destroy
    tr.reload
    expect(tr.category_id).to eq(nil)
    pl.reload
    expect(pl.category_id).to eq(nil)
  end
 end
