class Booking < ApplicationRecord
  belongs_to :customer, class_name: 'User', foreign_key: 'customer_id'
  belongs_to :event
  belongs_to :ticket

  validate :validate_ticket_quantity

  private

  def validate_ticket_quantity
    if ticket && quantity > ticket.availability
      errors.add(:base, "Not enough available tickets for #{ticket.name}")
    end
  end
end
