class CreateMemes < ActiveRecord::Migration
  def change
    create_table :memes do |t|
      t.string :caption
      t.references :user, index: true, foreign_key: true
      t.references :picture, index: true, foreign_key: true
      t.integer :votes
      t.boolean :winner
      
      t.timestamps null: false
    end
  end
end