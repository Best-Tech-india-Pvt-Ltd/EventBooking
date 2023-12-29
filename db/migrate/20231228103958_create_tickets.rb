class CreateTickets < ActiveRecord::Migration[7.1]
  def change
    create_table :tickets do |t|
      t.references :event, null: false, foreign_key: true
      t.string :name
      t.decimal :price
      t.integer :availability
      t.timestamps
    end
  end
end
