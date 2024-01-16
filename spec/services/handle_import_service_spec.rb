require 'rails_helper'

RSpec.describe HandleImport, type: :model do
  before(:example) do
    @user = create(:user, :normal)
    @account = create(:account, user: @user)
    @file = File.join(Rails.root, 'spec', 'test.xlsx')
  end

  it 'returns a hash of 2 k/v pairs containing file data' do
    hash = HandleImport.new(@account, @file).get_attributes
    expect(hash.keys.size).to eq(2)
    # testing data of row 2 which has all mandatory fields
    expect(hash[2][0]).to eq(Date.new(2023, 11, 29))
    expect(hash[2][1]).to eq('brasserie')
    expect(hash[2][2]).to eq(25.75)
    expect(hash[2][3]).to eq('debit')
    expect(hash[2][4]).to eq('Soirée collègues')
    expect(hash[2][5]).to eq(nil)
    expect(hash[2][6]).to eq(true)
  end

  it 'returns an empty array if one mandatory field is absent' do
    hash = HandleImport.new(@account, @file).get_attributes
    # testing data of row 3 where date is missing
    expect(hash.keys.size).to eq(2)
    expect(hash[3]).to eq([])
  end
end
