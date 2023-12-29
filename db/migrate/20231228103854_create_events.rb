class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string :event_name
      t.date :event_date
      t.string :event_venue
      t.timestamps
    end
  end
end
