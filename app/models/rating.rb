class Rating < ActiveRecord::Base
  belongs_to :ingredient, dependent: :destroy
  belongs_to :user, dependent: :destroy
  validates :rating, numericality: { only_integer: true },
                     inclusion: { in: 0..100 }
  def scale

  end

end
