class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :title
      t.string :type
      t.string :description
      t.date :start_date
      t.date :end_date
      t.string :location
      t.string :time
      t.integer :age_limit
      t.integer :price
      t.integer :host_id

      t.timestamps
    end
  end
end
