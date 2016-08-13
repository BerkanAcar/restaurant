class AddCategoryIdToPlaces < ActiveRecord::Migration[5.0]
  def change
  	add_foreign_key :places, :categories
  end
end
