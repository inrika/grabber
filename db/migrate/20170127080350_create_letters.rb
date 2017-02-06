class CreateLetters < ActiveRecord::Migration[5.0]
  def change
    create_table :letters do |t|
      t.text :text
      t.date :date
      t.boolean :isRead
      t.integer :filesCount
      t.references :account, foreign_key: true

      t.timestamps
    end
  end
end
