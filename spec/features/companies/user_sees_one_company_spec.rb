require 'rails_helper'

describe "User sees one company" do
  scenario "a user sees a company" do
    category = Category.create!(title: 'Web Development')
    company = Company.create!(name: "ESPN")
    job = Job.create!(title: "Developer", level_of_interest: 90, city: "Denver", company_id: company.id, category_id: category.id)

    visit company_path(company)

    expect(current_path).to eq("/companies/#{company.id}")
    expect(page).to have_content("ESPN")
    expect(page).to have_content("Developer")
  end
end
