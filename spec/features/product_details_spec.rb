require 'rails_helper'

RSpec.feature "Visitor navigates to product details page", type: :feature, js: true do
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

  scenario "confirm you can click on product details and go to details page" do 
    visit root_path
    # save_screenshot
    first("article.product").find_link("Details").click
    expect(page).to have_content "Quantity"
    # save_screenshot
  end
end
