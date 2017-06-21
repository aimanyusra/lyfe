class AddNamePriceLinkToStylePhotos < ActiveRecord::Migration[5.0]
  def change
  	add_column :style_photos, :name, :string
  	add_column :style_photos, :price, :string
  	add_column :style_photos, :link, :string
  end
end
