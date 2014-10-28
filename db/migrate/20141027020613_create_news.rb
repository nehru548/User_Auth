class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.string :name
      t.string :news

      t.timestamps
    end
  end
end
