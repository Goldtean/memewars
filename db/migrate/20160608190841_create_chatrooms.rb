class CreateChatrooms < ActiveRecord::Migration[5.0]
  def change
    create_table :chatrooms do |t|
      t.string :topic
      t.string :slug, null: false
      t.boolean :private
      t.timestamps null: false
    end
  end
end