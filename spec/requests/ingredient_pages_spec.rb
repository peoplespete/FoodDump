require 'spec_helper'
require 'vcr_helper'

describe "Ingredient Pages" do
  before { visit root_url }
  subject { page }

  describe "food eating" do
    before { visit new_ingredient_path }

    describe "make yummly search" do
      before { fill_in "ingredient_search", with: "Mashed Potatoes" }
      it "should add recipe ingredients to db" do
        VCR.use_cassette('yummly search mashed potatoes') do
          expect { click_button "Add" }.to change(Ingredient, :count)
        end
      end

      describe "working search" do
        before do
          fill_in "ingredient_search", with: "Fried Apple Pie"
          VCR.use_cassette('yummly search fried apple pie') do
            click_button "Add"
          end
        end

        it { should have_content('Fried Apple Pie Added!') }
        it { should have_title('Food Dump') }
      end

      describe "failing search" do
        before do
          fill_in "ingredient_search", with: "4fj74f"
          VCR.use_cassette('yummly search 4fj74f') do
            click_button "Add"
          end
        end
        error_message = "Sorry we couldn't find that food, please try again with a different search term"
        it { should have_content(error_message) }
        it { should have_title('Enter food') }
      end
    end
  end
end
