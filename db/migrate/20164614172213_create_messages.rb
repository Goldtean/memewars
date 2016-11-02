class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :content, null: false
      t.references :chatroom_player, index: true, foreign_key: true, null: false
      t.references :chatroom, index: true, foreign_key: true, null: false
      t.timestamps null: false
    end
  end
end