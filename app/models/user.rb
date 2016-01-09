class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :ingredients, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_many :foods, dependent: :destroy
  has_many :dumps, dependent: :destroy
end
