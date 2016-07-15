class ChatroomPictures < ActiveRecord::Migration[5.0]
  def change
    create_table :chatroom_pictures do |t|
      t.references :picture, index: true, foreign_key: true
      t.references :chatroom, index: true, foreign_key: true
      t.boolean :winner
    end
  end
end
