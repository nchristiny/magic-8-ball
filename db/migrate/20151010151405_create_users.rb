class CreateUsers < ActiveRecord::Migration
  def change
    create_users do |t|
      t.string :username, null: false
      t.string :email, null: false
      t.string :hashed_password, null: false

      t.timestamps null: false
    end
  end
end
