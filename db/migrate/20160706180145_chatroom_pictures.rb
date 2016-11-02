class ChatroomPictures < ActiveRecord::Migration[5.0]
  def change
    create_table :chatroom_pictures do |t|
      t.references :picture, index: true, foreign_key: true, null: false
      t.references :chatroom, index: true, foreign_key: true, null: false
      t.boolean :winner
      t.timestamps null: false
    end
  end
end
