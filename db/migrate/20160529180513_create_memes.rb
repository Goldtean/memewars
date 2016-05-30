class CreateMemes < ActiveRecord::Migration
  def change
    create_table :memes do |t|
      t.string :caption
      t.integer :user_id
      t.integer :picture_id
    end
  end
end
