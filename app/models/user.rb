class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :ingredients
  has_many :ratings
  has_many :foods
  has_many :dumps

  # attr_accessible :email, :password, :password_confirmation
end
