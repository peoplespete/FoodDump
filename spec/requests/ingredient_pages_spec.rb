require 'spec_helper'

describe "Ingredient Pages" do
  before { visit root_url }
  subject { page }

  describe "food eating" do
    before { visit new_ingredient_path }

    describe "make yummly search" do
      before { fill_in "ingredient_search", with: "Mashed Potatoes" }
      it "should add recipe ingredients to db" do
        expect { click_button "Search" }.to change(Ingredient, :count)
      end

      describe "working search" do
        before do
          fill_in "ingredient_search", with: "Fried Apple Pie"
          click_button "Search"
        end
        it { should have_content('Fried Apple Pie Added!') }
      end

      describe "failing search" do
        before do
          fill_in "ingredient_search", with: "4fj74f"
          click_button "Search"
        end
        error_message = "Sorry we couldn't find that food, please try again with a different search term"
        it { should have_content(error_message) }
      end
    end
  end
end