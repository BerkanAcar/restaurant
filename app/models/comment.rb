class Comment < ApplicationRecord
	belongs_to :place
	belongs_to :customer
	validates :body, presence: true, length: {minimum: 5}
end
