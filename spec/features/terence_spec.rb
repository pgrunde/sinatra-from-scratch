require "spec_helper"

feature "homepage" do
  before(:each) do
    visit "/"
  end
  scenario "visitor visits homepage" do
    expect(page).to have_content("Sign Up")
  end
end