class CreateAdmins < ActiveRecord::Migration
  def change
    create_table :admins do |t|
      t.string :username
      t.string :email
      t.string :encrypted_password
      t.string :salt
      t.string :gender

      t.timestamps
    end
  end
end
