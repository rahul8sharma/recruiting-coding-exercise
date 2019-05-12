require 'rails_helper'

RSpec.describe Product, type: :model do
  describe '#price' do
    it 'returns a float' do
      expect(Product.new(price_in_cents: 1234).price).to eq(12.34)
    end
  end

  describe '#Valid get_price_by_currency' do
    it 'returns a float' do
      expect(Product.new(price_in_cents: 1234).get_price_by_currency('USD')).to eq(13.86)
    end
  end

  describe '#Invalid get_price_by_currency' do
    it 'returns a error' do
      expect(Product.new(price_in_cents: 1234).get_price_by_currency('ABC')).to eq(["Currency type is invalid"])
    end
  end
end
