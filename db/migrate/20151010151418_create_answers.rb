class CreateAnswers < ActiveRecord::Migration
  def change
    create_answers do |t|
      t.text :body, null: false
      t.integer :user_id, null: false
      t.integer :ball_id, null: false

      t.timestamps null: false
    end
  end
end
