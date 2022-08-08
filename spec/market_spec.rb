require './lib/item'
require './lib/vendor'
require './lib/market'

RSpec.describe Market do
  let(:market) {described_class.new('South Pearl Street Farmers Market')}

  let(:vendor1) {Vendor.new('Rocky Mountain Fresh')}
  let(:vendor2) {Vendor.new('Ba-Nom-a-Nom')}
  let(:vendor3) {Vendor.new('Palisade Peach Shack')}

  let(:item1) {Item.new({name: 'Peach', price: '$0.75'})}
  let(:item2) {Item.new({name: 'Tomato', price: '$0.50'})}
  let(:item3) {Item.new({name: 'Peach-Raspberry Nice Cream', price: '$5.30'})}
  let(:item4) {Item.new({name: 'Banana Nice Cream', price: '$4.25'})}
  
  describe 'Iteration 2 tests' do
    it 'exists as class' do
      expect(market).to be_a(Market)
    end

    it 'Market has attributes' do
      expect(market.name).to eq('South Pearl Street Farmers Market')
      expect(market.vendors).to eq([])
    end

    it 'Market can add Vendors' do
      market.add_vendor(vendor1)
      market.add_vendor(vendor2)
      market.add_vendor(vendor3)

      expect(market.vendors).to eq([vendor1, vendor2, vendor3])
    end

    it 'Market Vendors hav names' do
      market.add_vendor(vendor1)
      market.add_vendor(vendor2)
      market.add_vendor(vendor3)

      expect(market.vendors_names).to eq(['Rocky Mountain Fresh', 'Ba-Nom-a-Nom', 'Palisade Peach Shack'])
    end

    it 'Market finds which Vendors sells which Items' do
      market.add_vendor(vendor1)
      market.add_vendor(vendor2)
      market.add_vendor(vendor3)

      vendor1.stock(item1, 35)
      vendor1.stock(item2, 7)
      vendor2.stock(item4, 50)
      vendor2.stock(item3, 25)
      vendor3.stock(item1, 65)

      expect(market.vendors_that_sell(item1)).to eq([vendor1, vendor3])
      expect(market.vendors_that_sell(item4)).to eq([vendor2])
    end

    describe 'Iteration 3 Tests' do
      before do
        market.add_vendor(vendor1)
        market.add_vendor(vendor2)
        market.add_vendor(vendor3)
  
        vendor1.stock(item1, 35)
        vendor1.stock(item2, 7)
        vendor2.stock(item3, 25)
        vendor2.stock(item4, 50)
        vendor3.stock(item1, 65)
        vendor3.stock(item3, 10)
      end

      it 'Market calculate total inventory of Items' do
        expected_hash = {item1 => {quantity: 100, vendors: [vendor1, vendor3]},
                        item2 => {quantity: 7, vendors: [vendor1]},
                        item3 => {quantity: 35, vendors: [vendor2, vendor3]},
                        item4 => {quantity: 50, vendors: [vendor2]}
                        }
        expect(market.total_inventory).to eq(expected_hash)
      end

      it 'Market can determine overstocked items' do
# An item is overstocked if it is 
# sold by more than 1 vendor AND the total quantity is greater than 50.
        expect(market.overstocked_items).to eq([item1])
      end

      it 'Market can have sorted list of Items' do
        expect(market.sorted_item_list).to eq(["Banana Nice Cream", "Peach", "Peach-Raspberry Nice Cream", "Tomato"])
      end
    end
  end
end