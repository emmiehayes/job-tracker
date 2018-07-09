require 'rails_helper'

describe Job do
  describe "validations" do
    context "invalid attributes" do
      it "is invalid without a title" do
        job = Job.new(level_of_interest: 80, description: "Wahoo", city: "Denver")
        expect(job).to be_invalid
      end

      it "is invalid without a level of interest" do
        job = Job.new(title: "Developer", description: "Wahoo", city: "Denver")
        expect(job).to be_invalid
      end

      it "is invalid without a city" do
        job = Job.new(title: "Developer", description: "Wahoo", level_of_interest: 80)
        expect(job).to be_invalid
      end
    end

    context "valid attributes" do
      it "is valid with a title, level of interest, and company" do
        company = Company.new(name: "Turing")
        category = Category.new(title: "Web Development")
        job = Job.new(title: "Developer", level_of_interest: 40, city: "Denver", company: company, category: category)
        expect(job).to be_valid
      end
    end
  end

  describe "relationships" do
    it "belongs to a company" do
      job = Job.new(title: "Software", level_of_interest: 70, description: "Wahooo")
      expect(job).to respond_to(:company)
      expect(job).to respond_to(:category)
    end
  end

  describe 'class methods' do
    context 'it can group by level of interest' do
      it '.group_by_interest' do
        category_1 = Category.create!(title: 'Web Development')
        category_2 = Category.create!(title: 'Education')
        category_3 = Category.create!(title: 'Sales')
        category_4 = Category.create!(title: 'Accounting')
        company_1 = Company.create!(name: "ESPN")
        company_2 = Company.create!(name: "Turing")
        company_3 = Company.create!(name: "Macy's")
        company_4 = Company.create!(name: "Adidas")
        job_1 = Job.create!(title: "Developer", level_of_interest: 4, city: "Denver", company_id: company_1.id, category_id: category_1.id)
        job_2 = Job.create!(title: "Teacher", level_of_interest: 5, city: "Boulder", company_id: company_2.id, category_id: category_2.id)
        job_3 = Job.create!(title: "Sales Rep", level_of_interest: 2, city: "New York", company_id: company_3.id, category_id: category_1.id)
        job_4 = Job.create!(title: "Accountant", level_of_interest: 5, city: "Seattle", company_id: company_4.id, category_id: category_4.id)

        expect(Job.amount_by_rating(5)).to eq(2)
        expect(Job.amount_by_rating(4)).to eq(1)
        expect(Job.amount_by_rating(3)).to eq(0)
        expect(Job.amount_by_rating(2)).to eq(1)
        expect(Job.amount_by_rating(1)).to eq(0)
      end
    end
  end
end
