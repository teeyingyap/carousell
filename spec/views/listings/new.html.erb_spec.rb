require 'rails_helper'

RSpec.feature "Listing", :type => :feature do
 	before :all do
      user = User.create(username: 'yty', email: 'yty@gmail.com', password: '12345678')
    end
    scenario "Create a listing" do
  	  visit "/"
      click_button "Login"
      within("#myModal") do 
        fill_in "Email", :with => "yty@gmail.com" 
        fill_in "Password", :with => "12345678"
        click_button "Log In"
      end 

      click_link "Sell"
    
      expect(page).to have_text("SELL AN ITEM") 

      fill_in "What are you selling?", :with => "Iphone"
      fill_in "Price", :with => "2000"
      click_button "Create Listing"
      expect(page).to have_text("Iphone") 
  end 
end  

