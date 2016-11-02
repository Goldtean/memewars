class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :chatroom_player, index: true, foreign_key: true, null: false
      t.references :meme, index: true, foreign_key: true, null: false
      t.timestamps null: false
    end
  end
end
