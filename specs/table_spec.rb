require 'rspec'
require_relative '../app'

FILE = './test.csv'

describe Table do
  before(:each) do
    File.delete(FILE)
  end

  describe '.create' do
    it 'adds a row to the table' do
      table = Table.new(FILE)
      row =table.create name: 'Nathan', hat: 'Cowboy'

      expect(row.name).to eq('Nathan')
      expect(row.to_s).to eq('Nathan (ID 1) wears a Cowboy hat.')
    end
  end

  # describe '.all' do
  #   it 'loads all of the rows from the csv' do
  #     table = Table.new(FILE)
  #   end
  # end
end
