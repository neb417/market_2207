require './lib/item'
require './lib/vendor'

RSpec.describe Item do
  let(:item1) {described_class.new({name: 'Peach', price: '$0.75'})}
  let(:item2) {described_class.new({name: 'Tomato', price: '$0.50'})}

  describe 'Iteration 1 tests' do
    it 'exists as class' do
      expect(item1).to be_a(Item)
      expect(item2).to be_a(Item)
    end

    it 'Items have attributes' do
      expect(item1.name).to eq('Peach')
      expect(item1.price).to eq('$0.75')
      expect(item2.name).to eq('Tomato')
      expect(item2.price).to eq('$0.50')  
    end
  end
end