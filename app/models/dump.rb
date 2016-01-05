class Dump < ActiveRecord::Base
  belongs_to :user, dependent: :destroy
  validates :rating, numericality: { only_integer: true }
end
