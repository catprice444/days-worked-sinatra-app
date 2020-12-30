class CreateWorkdays < ActiveRecord::Migration[6.0]
  def change
    create_table :workdays do |t|
      t.integer :user_id
      t.datetime :shift_start
      t.datetime :shift_end
      t.text :notes
    end 
  end
end
