class Place < ApplicationRecord
	validates :places, :name, presence: true
	validates :places, :phone_number, presence: true
	validates :places, :address, presence: true, length: {maximum: 100}
	validates :places, :city, presence: true
	validates :places, :description, length: {maximum: 500}
	validate :check_established_to
	validates_format_of :contact_email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
	def check_planned_to
	 	if established_to.present? && established_to > Date.today #nill? && ..
	 		errors.add(:established_to, "Kuruluş tarihi bugünün tarihinden büyük olamaz.")
	 	end
	end
end
