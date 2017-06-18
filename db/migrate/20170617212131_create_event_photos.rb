class CreateEventPhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :event_photos do |t|
      t.integer :event_id
      t.string :image

      t.timestamps
    end
  end
end
