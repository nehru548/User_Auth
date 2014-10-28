class CreateCenters < ActiveRecord::Migration
  def change
    create_table :centers do |t|
      t.integer :movie_id
      t.string :name

      t.timestamps
    end
  end
end
