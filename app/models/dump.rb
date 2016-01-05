class Dump < ActiveRecord::Base
  validates :rating, numericality: { only_integer: true }
end
