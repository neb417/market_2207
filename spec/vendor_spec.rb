require './lib/item'
require './lib/vendor'

RSpec.describe Vendor do
  let(:vendor) {described_class.new('Rocky Mountain Fresh')}
  let(:item1) {Item.new({name: 'Peach', price: '$0.75'})}
  let(:item2) {Item.new({name: 'Tomato', price: '$0.50'})}

  describe 'Iteration 1 tests' do
    it 'exists as class' do
      expect(vendor).to be_a(Vendor)
    end

    it 'Vendor has attributes' do
      expect(vendor.name).to eq('Rocky Mountain Fresh')
      expect(vendor.inventory).to eq({})
    end

    it 'Vendor stock is empty by default' do
      expect(vendor.check_stock(item1)).to eq(0)
    end

    it 'Vendor can stock Items' do
      vendor.stock(item1, 30)

      expect(vendor.inventory).to eq({item1 => 30})
      expect(vendor.check_stock(item1)).to eq(30)
    end

    it 'Vendor Invetory adds to items' do
      vendor.stock(item1, 30)
      vendor.stock(item1, 25)
      expect(vendor.check_stock(item1)).to eq(55)

      vendor.stock(item2, 12)
      
      expect(vendor.inventory).to eq({item1 => 55, item2 => 12})
    end
  end
end