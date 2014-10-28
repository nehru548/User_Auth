class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.string :user_name
      t.string :movie_name
      t.integer :rating
      t.string :comment

      t.timestamps
    end
  end
end
