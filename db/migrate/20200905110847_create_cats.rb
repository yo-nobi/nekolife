class CreateCats < ActiveRecord::Migration[5.2]
  def change
    create_table :cats do |t|
      t.string :name
      t.date :birthday
      t.string :variety
      t.string :contents
      t.string :image
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
