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

    describe "valid rating" do
      let(:rating) { Rating.new(rating: 52) }
      subject { rating }

      it { should be_valid }
    end

    describe "invalid rating" do

      describe "too high" do
        let(:rating) { Rating.new(rating: 101) }
        subject { rating }

        it { should_not be_valid }
      end

      describe "too small" do
        let(:rating) { Rating.new(rating: -1) }
        subject { rating }

        it { should_not be_valid }
      end

    end
  end
end
