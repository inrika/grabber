class AddTimestampToLetters < ActiveRecord::Migration[5.0]
  def change
    add_column :letters, :timestamp, :datetime
  end
end
