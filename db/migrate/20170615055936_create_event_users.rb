class CreateEventUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :event_users do |t|
      t.references :event, foreign_key: true
      t.references :user, foreign_key: true
    end
  end
end
