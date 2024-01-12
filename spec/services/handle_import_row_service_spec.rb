require 'rails_helper'

RSpec.describe HandleImportRow, type: :model do
  before(:example) do
    @user = create(:user, :normal)
    @category = create(:category3, user: @user)
    @account = create(:account, user: @user)
    @row = [Date.today, 'cpam','', '15,25', 'remboursement medecin', 'divers', 'oui']
  end

  it 'returns an array of 7 elements' do
    array = HandleImportRow.new(@account, @row).get_attributes
    expect(array.size).to eq(7)
    expect(array[0]).to eq(Date.today)
    expect(array[1]).to eq('cpam')
    expect(array[2]).to eq(15.25)
    expect(array[3]).to eq('credit')
    expect(array[4]).to eq('remboursement medecin')
    expect(array[5]).to eq(@category.id)
    expect(array[6]).to eq(true)
  end

  it 'retruns an empty array if one mandatory field is absent' do
    @row = @row[1..-1]
    array = HandleImportRow.new(@account, @row).get_attributes
    expect(array.present?).to eq(false)
  end
end
