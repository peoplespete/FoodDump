class Ingredient < ActiveRecord::Base
  belongs_to :user, dependent: :destroy
  has_many :ratings
  # validates :name, uniqueness: true


  def search
  end

  def source
  end

end
