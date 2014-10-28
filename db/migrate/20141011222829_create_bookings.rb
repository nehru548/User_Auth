class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.integer :movie_id
      t.integer :center_id
      t.date :date
      t.string :time
      t.integer :no_tickets

      t.timestamps
    end
  end
end
