class AddImagesToStyles < ActiveRecord::Migration[5.0]
  def change
  	  	add_column :styles, :images, :string, array: true, default: [] # add images column as array
  end
end
