class Dump < ActiveRecord::Base
  belongs_to :user
  validates :rating, numericality: { only_integer: true }
end
