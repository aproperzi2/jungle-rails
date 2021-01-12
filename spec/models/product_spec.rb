require 'rails_helper'

RSpec.describe Product, type: :model do
  describe "Validation" do
    it "is valid with valid attributes" do
      @category = Category.new(name: "test")
      @product = Product.new(name: "test", price: 5, quantity: 20, category: @category)
      expect(@product).to be_valid
    end
    it "is not valid without a name" do
      @category = Category.new(name: "test")
      @product = Product.new(name: nil, price: 5, quantity: 20, category: @category)
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end
    it "is not valid without a price" do
      @category = Category.new(name: "test")
      @product = Product.new(name: "test", price: nil, quantity: 20, category: @category)
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end
    it "is not valid without a quantity" do
      @category = Category.new(name: "test")
      @product = Product.new(name: "test", price: nil, quantity: nil, category: @category)
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end
    it "is not valid without a category" do
      @category = Category.new(name: "test")
      @product = Product.new(name: "test", price: nil, quantity: 20, category: nil)
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
  end
end
