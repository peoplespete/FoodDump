require 'spec_helper'
require 'vcr_helper'

describe "Recommendation Pages" do
  before { visit root_url }
  subject { page }

  describe "getting a recommendation" do
    before do
      2.times do
        visit new_ingredient_path
        fill_in "ingredient_search", with: "Crave-Worthy Sugar Cookies"
        VCR.use_cassette('yummlysearch Crave-Worthy Sugar Cookies') do
          click_button "Add"
        end
        visit new_rating_path
        find(:xpath, "//input[@id='rating_scale']").set 57
        click_button "Save"
      end
      visit new_recommendation_path
    end

    describe "looking up ingredient in table" do
      before do
        fill_in "search", with: "sugar"
        click_button "Search"
      end
      it { should_not have_content("Sorry we couldn't find enough information")}
      it { should_not have_content("Sorry we couldn't find that food")}
      it { should have_content("Sugar gets an eatability rating of 86") }
      it { should have_title("Eatability of Sugar") }
    end

    describe "using yummly for food lookup" do
      before do
        fill_in "search", with: "Oreo Stuffed Chocolate Chip Cookies"
        VCR.use_cassette('yummlysearch Oreo Stuffed Chocolate Chip Cookies') do
          click_button "Search"
        end
      end

      it { should have_content("Oreo Stuffed Chocolate Chip Cookies get an eatability rating of 86") }
      it { should have_title("Eatability of Oreo Stuffed Chocolate Chip Cookies") }
    end
  end
end
