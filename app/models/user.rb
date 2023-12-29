class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, 
         :jwt_authenticatable, jwt_revocation_strategy: self
  

  has_many :events, foreign_key: 'organizer_id', class_name: 'Event', dependent: :destroy 
  has_many :bookings, foreign_key: 'customer_id', class_name: 'Booking', dependent: :destroy
  enum role: [:event_organizer, :customer]  

  def jwt_payload
    super
  end    

  def event_organizer?
    role == "event_organizer"
  end

  def customer?
    role == "customer"
  end
end
