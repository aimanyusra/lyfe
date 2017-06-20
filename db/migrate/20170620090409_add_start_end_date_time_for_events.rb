class AddStartEndDateTimeForEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :start_time, :date_time
    add_column :events, :end_time, :date_time
  end
end
