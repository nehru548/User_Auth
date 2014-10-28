class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :username
      t.string :movie_name
      t.string :center_name
      t.date :date
      t.string :time
      t.integer :no_tickets
      t.integer :price
      t.string :seat_number

      t.timestamps
    end
  end
end
