class ChangeColumnName < ActiveRecord::Migration[5.0]
  def change
  	remove_column :events, :type
  	add_column :events, :status, :string
  end
end
