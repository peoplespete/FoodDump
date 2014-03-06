require 'spec_helper'

describe "Rating Pages" do
  before { visit root_url }
  subject { page }

  describe "pooping" do
    before do
      visit new_rating_path
    end
      let!(:avocado) { FactoryGirl.create(:ingredient, name: 'avocado',
                                         pending: true) }

    describe "add a poop" do
      before do
        find(:xpath, "//input[@id='rating_scale']").set 57
      end

      it "should add poop ratings to db" do
        expect { click_button "Save" }.to change(Rating, :count)
      end

      describe "working rating" do
        before { click_button "Save" }

        it { should have_content('Rating of 57 Added!') }
        it { should have_title('Food Dump') }
      end
    end
  end
end