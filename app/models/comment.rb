class Comment < ApplicationRecord
	belongs_to :place
	validates :body, presence: true, length: {minimum: 5}
end
