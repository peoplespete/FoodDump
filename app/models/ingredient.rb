class Ingredient < ActiveRecord::Base
  has_many :ratings
  validates :name, uniqueness: true

end
