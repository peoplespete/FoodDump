require 'spec_helper'

describe Rating do

  describe "rating should be valid" do

    let(:ingred) { FactoryGirl.create(:ingredient) }
    before { @rating = ingred.ratings.build(rating: 43) }
    subject { @rating }

    it { should respond_to(:ingredient_id) }
    it { should respond_to(:rating) }
    it { should respond_to(:ingredient) }

    it { should be_valid }

  end
end
