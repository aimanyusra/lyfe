class CreateStyleTags < ActiveRecord::Migration[5.0]
  def change
    create_table :style_tags do |t|
      t.references :style, foreign_key: true
      t.references :tag, foreign_key: true

      t.timestamps
    end
  end
end
