class AddPriceToStyle < ActiveRecord::Migration[5.0]
  def change
  	add_column :styles, :price, :string
  end
end
