class StylePhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :style_photos do |t|
      t.integer :style_id
      t.string :image

      t.timestamps
    end
  end
end
