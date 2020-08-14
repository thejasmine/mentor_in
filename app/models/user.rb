class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  acts_as_token_authenticatable
  has_many :events
  has_many :appointments
  has_many :appointments_as_owner, through: :events, source: :appointments

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
