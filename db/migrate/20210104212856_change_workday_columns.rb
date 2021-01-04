class ChangeWorkdayColumns < ActiveRecord::Migration
  def change
    change_column :workdays, :shift_start_time, :string
    change_column :workdays, :shift_end_time, :string
  end
end
