require 'rails_helper'

RSpec.feature "Registered user may login successfully", type: :feature, js: true do
  
  before :each do
    @user = User.new(first_name: "Test", last_name: "Last", email: "test@test.com", password: "12345", password_confirmation: "12345")
    @user.save!
  end

  scenario "confirm valid user can navigate to login page and login" do 
    visit root_path
    page.find('#navbar').find_link('User').click
    find_link('Login').click
    expect(page).to have_content "Email:"
    fill_in 'email', with: 'test@test.com'
    fill_in 'password', with: '12345'
    find_button('Submit').click
    expect(page).to have_content "Signed in as Test"
    sleep 3
    save_screenshot
  end
end
