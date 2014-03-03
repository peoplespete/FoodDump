require 'spec_helper'

describe "Rating Pages" do
  before { visit root_url }
  subject { page }

  describe "pooping" do
    before { visit new_rating_path }

    describe "add a poop" do
      before { fill_in "rating_scale", with: "57" }
      it "should add poop ratings to db" do
        expect { click_button "Save" }.to change(Rating, :count)
      end

      describe "working rating" do
        before do
          fill_in "rating_scale", with: "57"
          click_button "Save"
        end
        it { should have_content('Rating of 57 Added!') }
      end

      describe "failing rating" do
        before do
          fill_in "rating_scale", with: "-45"
          click_button "Save"
        end
        error_message = "Sorry we couldn't add that rating, please try again with a different rating"
        it { should have_content(error_message) }
      end
    end
  end
end