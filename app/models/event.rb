class Event < ApplicationRecord
    belongs_to :event_organizer, class_name: 'User', foreign_key: 'organizer_id'
    has_many :tickets, dependent: :delete_all
    accepts_nested_attributes_for :tickets

    validates :event_name, presence: true, length: { maximum: 255 }
    validates :event_date, presence: true
    validates :event_venue, presence: true
    validate :validate_event_date

  private

  def validate_event_date
    errors.add(:event_date, 'must be in the future') if event_date.present? && event_date < Date.today
  end

end
