class CreateMemes < ActiveRecord::Migration
  def change
    create_table :memes do |t|
      t.string :caption, null: false
      t.references :user, index: true, foreign_key: true, null: false
      t.references :picture, index: true, foreign_key: true, null: false
      t.integer :votes
      t.boolean :winner
      
      t.timestamps null: false
    end
  end
end