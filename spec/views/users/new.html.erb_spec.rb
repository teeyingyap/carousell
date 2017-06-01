require 'rails_helper'

RSpec.feature "User", :type => :feature do
  scenario "Create a new user" do
  	visit "/"
    click_button("Sign Up", :match => :first)
    within("#myModal1") do 

      fill_in "Email", :with => "qwe@mail.com" 
      fill_in "Username", :with => "qwee"
      fill_in "Password", :with => "12345678"
      click_button "Signup"
    end 

    expect(page).to have_text("@qwee") 

  end 
end  
 

