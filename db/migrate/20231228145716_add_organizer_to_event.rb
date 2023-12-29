class AddOrganizerToEvent < ActiveRecord::Migration[7.1]
  def change
    add_reference :events, :organizer, foreign_key: { to_table: :users }
    add_reference :bookings, :customer, null: false, foreign_key: { to_table: :users }
  end
end
