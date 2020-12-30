class CreateWorkdays < ActiveRecord::Migration
  def change
    create_table :workdays do |t|
      t.integer :user_id
      t.datetime :shift_start
      t.datetime :shift_end
      t.text :notes
    end 
  end
end
