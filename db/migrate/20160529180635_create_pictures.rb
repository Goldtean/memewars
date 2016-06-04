class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :category
      t.string :url
      t.timestamps null: false
    end
  end
end