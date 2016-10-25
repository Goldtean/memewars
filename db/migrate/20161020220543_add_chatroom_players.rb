class AddChatroomPlayers < ActiveRecord::Migration[5.0]
  def change
    create_table :chatroom_players do |t|
      t.references :user, index: true, foreign_key: :true, null: false
      t.references :chatroom, index: true, foreign_key: true, null: false
      t.boolean :creator, default: false
      t.string :status
      t.timestamps null: false
    end
  end
end
