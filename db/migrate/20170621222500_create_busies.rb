class CreateBusies < ActiveRecord::Migration[5.0]
  def change
    create_table :busies do |t|
      t.references :user, foreign_key: true
      t.date :day

      t.timestamps
    end
  end
end
