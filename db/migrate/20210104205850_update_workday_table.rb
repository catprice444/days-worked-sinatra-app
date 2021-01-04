class UpdateWorkdayTable < ActiveRecord::Migration
  def change
    add_column :workdays, :shift_start_time, :time
    add_column :workdays, :shift_end_time, :time
    change_column :workdays, :shift_start, :date
    change_column :workdays, :shift_end, :date
  end
end
