class PlacesController < ApplicationController
	before_action :get_place, only: [:edit, :update, :show, :destroy]
	before_action :authenticate_owner!, except: [:index, :show]
	before_action :authorize_owner!, only: [:edit, :update, :destroy]
	def index
		@places = Place.all
	end

	def new
		@place = Place.new
		get_categories
	end

	def create
		@place = current_owner.places.new(place_params)
		if @place.save
			flash[:success] = "Kayıt başarıyla oluşturuldu."
			redirect_to place_path(@place)
		else
			get_categories
			render :new
		end
	end

	def show
		@comment = Comment.new
	end

	def edit
		get_categories
	end

	def update
		if @place.update(place_params)
			redirect_to place_path(@place)
		else
			get_categories
			render :edit
		end
	end

	def destroy
		if @place.destroy
			redirect_to places_path
		end
	end

	private

		def get_place
			@place = Place.find(params[:id])
		end

		def authorize_owner!
			redirect_to root_path, notice: 'Başkasının verilerine müdahele edemezsin!!!' unless @place.owner_id == current_owner.id
		end

		def get_categories
			@categories = Category.all.collect {|c| [c.title, c.id]}
		end

		def place_params
			params.require(:place).permit(:name, :address, :established_at, :phone_number, :contact_mail, :city, :description, :category_id)
		end
end
