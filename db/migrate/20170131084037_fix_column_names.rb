class FixColumnNames < ActiveRecord::Migration[5.0]
  def change

      change_table :letters do |t|
        t.rename :isRead, :is_read
        t.rename :filesCount, :files_count    
      end

  end
end
