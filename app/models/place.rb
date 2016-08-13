class Place < ApplicationRecord
	def category
		Category.find(category_id)
	end
end
