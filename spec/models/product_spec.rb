require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before do
      @category = Category.new(name: 'Cherry Blossoms')
      @product = Product.new(
        name: 'Cactus',
        price_cents: 10000,
        quantity: 5,
        category: @category
      )
    end

    it 'saves successfully when all fields are set' do
      expect(@product.save).to be true
    end

    it 'validates presence of name' do
      @product.name = nil
      @product.save
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it 'validates presence of price' do
      @product.price_cents = nil
      @product.save
      expect(@product.errors.full_messages).to include("Price cents is not a number")
    end

    it 'validates presence of quantity' do
      @product.quantity = nil
      @product.save
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'validates presence of category' do
      @product.category = nil
      @product.save
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
  end
end
