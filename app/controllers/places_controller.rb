class PlacesController < ApplicationController
	def index
		@places = Place.all
	end

	def new
		@place = Place.new
		get_categories
	end

	def create
		@place = Place.new(place_params)
		if @place.save
			flash[:success] = "Kayıt başarıyla oluşturuldu."
			redirect_to place_path(@place)
		else
			get_categories
			render :new
		end
	end

	def show
		@place = Place.find(params[:id])
		@comment = Comment.new
	end

	def edit
		@place = Place.find(params[:id])
		get_categories
	end

	def update
		@place = Place.find(params[:id])
		if @place.update(place_params)
			redirect_to place_path(@place)
		else
			get_categories
			render :edit
		end
	end

	def destroy
		@place = Place.find(params[:id])
		if @place.destroy
			redirect_to places_path
		end
	end

	private
		def get_categories
			@categories = Category.all.collect {|c| [c.title, c.id]}
		end

		def place_params
			params.require(:place).permit(:name, :address, :established_at, :phone_number, :contact_mail, :city, :description, :category_id)
		end
end
