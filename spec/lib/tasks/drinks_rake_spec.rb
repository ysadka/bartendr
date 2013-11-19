require 'spec_helper'
require 'csv'

describe 'parse_drinks' do
  include_context 'rake'

  it 'creates a drink associated to the appropriate glass' do
    row = mock_csv_row
    CSV.stub(:foreach).and_yield row
    GLASS_MAPPING.stub(:fetch).and_return 'Old Fashioned'
    glass = create(:glass, name: 'Old Fashioned')

    rake

    drink = Drink.last
    expect(drink.name).to eq row[:name].downcase
    expect(drink.preparation).to eq row[:preparation]
    expect(drink.url).to eq row[:url]
    expect(drink.glass).to eq glass
  end

  it 'associates a Pint glass as a default glass' do
    row = mock_csv_row
    CSV.stub(:foreach).and_yield row
    stub_const 'GLASS_MAPPING', {}
    glass = create(:glass, name: 'Pint')

    rake

    drink = Drink.last
    expect(drink.glass).to eq glass
  end
end

def mock_csv_row
  row = {
    name:        'Sidecar',
    preparation: 'Shake',
    url:         'http://www.bartendr.me',
    glass:       'http://www.bartendr.me/glasses/5/'
  }
end
