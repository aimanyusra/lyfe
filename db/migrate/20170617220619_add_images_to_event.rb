class AddImagesToEvent < ActiveRecord::Migration[5.0]
  def change
  	add_column :events, :images, :string, array: true, default: [] # add images column as array
  end
end

