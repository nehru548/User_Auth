class CreateFilms < ActiveRecord::Migration
  def change
    create_table :films do |t|
      t.string :name
      t.string :director
      t.string :actors
      t.string :description

      t.timestamps
    end
  end
end
