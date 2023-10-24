require 'rails_helper'

RSpec.describe Source, type: :model do
  before(:each) do
    @source = create(:source_one)
  end
  it 'is invalid if name is absent' do
    one = Source.new(name: '', url: 'http://www.blabla.fr')
    expect(one).to_not be_valid
  end

  it 'is invlaid if url is absent' do
    one = Source.new(name: 'source', url: nil)
    expect(one).to_not be_valid
  end

  it 'is invalid if name is not unique' do
    one = Source.new(name: 'lemonde', url: 'http://www.blabla.fr') # same name as @source
    expect(one).to_not be_valid
  end
  it 'is invalid if url is not unique' do
    one = Source.new(name: 'source', url: 'https://www.lemonde.fr/rss/une.xml') # same url as @source
    expect(one).to_not be_valid
  end

  it 'is valid if url and name are present and unique' do
    one = Source.new(name: 'source', url: 'http://www.blabla.fr') # name and url different from @source
    expect(one).to be_valid
  end
end
