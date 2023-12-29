class Ticket < ApplicationRecord
  belongs_to :event
  has_many :bookings, dependent: :destroy

  validates :name, presence: true, length: { maximum: 100 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :availability, presence: true, numericality: { greater_than_or_equal_to: 0 }

  scope :available, -> { where('availability > 0') }
end
