require 'rails_helper'

RSpec.feature "Visitor adds item to cart and cart value increases by 1", type: :feature, js: true do
  before :each do 
    @category = Category.create! name: 'Apparel'

    10.times do |n| 
      @category.products.create!(
        name: Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "confirm you can click on add to cart and cart value is incremented by 1" do 
    visit root_path
    # save_screenshot
    first("article.product").find_button("Add").click
    expect(page).to have_content "My Cart (1)"
    save_screenshot
  end
end
