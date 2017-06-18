class CreateStyles < ActiveRecord::Migration[5.0]
  def change
    create_table :styles do |t|
      t.string :name
      t.string :tags, array: true, default: []
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
