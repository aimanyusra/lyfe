class CreateFriends < ActiveRecord::Migration[5.0]
  def change
    create_table :friends do |t|
      t.integer :firstid
      t.integer :secondid
      t.integer :status

      t.timestamps
    end
  end
end
