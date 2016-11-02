class CreateMemes < ActiveRecord::Migration
  def change
    create_table :memes do |t|
      t.string :caption, null: false
      t.references :chatroom_player, index: true, foreign_key: true, null: false
      t.references :chatroom_picture, index: true, foreign_key: true, null: false
      t.integer :votes
      t.boolean :winner
      
      t.timestamps null: false
    end
  end
end