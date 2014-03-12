class Ingredient < ActiveRecord::Base
  has_many :ratings
  validates :name, uniqueness: true


  def search
  end

  def is_ingredient
  end

end
