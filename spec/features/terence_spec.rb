require "spec_helper"

feature "homepage" do
  before(:each) do
    visit "/"
  end
  scenario "visitor visits homepage" do
    expect(page).to have_content("Sign Up")
  end
  scenario "everything is entered properly" do
    fill_in "Name", :with => "peter"
    fill_in "Email", :with => "peter.a.grunde@gmail.com"
    click_button "Sign Up"
    expect(page).to have_content("giving the Blue Hat some email food")
  end
end