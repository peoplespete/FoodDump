require 'spec_helper'

describe Ingredient do

  describe "ingredient should be valid" do
    let(:ingred) { FactoryGirl.create(:ingredient, name: 'avocado') }

    subject { ingred }

    it { should respond_to(:name) }
    it { should respond_to(:pending) }
    it { should respond_to(:ratings) }
    it { should be_valid }

    describe "pending ingredient" do
      before { ingred.pending = true }

      its(:pending) { should == true }
    end

    describe "non-pending ingredient" do
      before { ingred.pending = false }

      its(:pending) { should == false }
    end

    describe "name must be unique" do
      before { ingred.save }
      let(:ingred1) { Ingredient.new(name: 'avocado') }

      subject { ingred1 }

      it { should_not be_valid }
    end

  end

end
