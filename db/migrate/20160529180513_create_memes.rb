class CreateMemes < ActiveRecord::Migration
  def change
    create_table :memes do |t|
      t.string :caption
      t.integer :user_id
      t.integer :picture_id
      t.integer :votes
      t.boolean :winner
      
      t.references :memeable, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end