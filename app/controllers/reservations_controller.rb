class ReservationsController < ApplicationController
	before_action :authenticate_customer!
	before_action :get_place
	before_action :get_reservation, only: [:destroy]
	before_action :authorize_customer!, only: [:update, :destroy]
  def create
  	@reservation = @place.reservations.new(reservation_params)
  	@reservation.customer = current_customer
  	if @reservation.save
  		redirect_to place_path(@place), notice: 'Rezervasyon oluşturuldu.'
  	else
  		redirect_to place_path(@place), notice: 'Rezervasyon oluşturulamadı. Eksik bilgi girdiniz.'
  	end
  end

  def update
  end

  def destroy
  	@reservation.destroy
  	redirect_to @place
  end
  private
  def get_reservation
  	@reservation = Reservation.find(params[:id])
  end

  def authorize_customer!
  	redirect_to @place, notice: 'Başkalarının rezervasyonlarına müdahele edemezsin!!!' unless @reservation.customer_id == current_customer.id
  end

  def get_place
  	@place = Place.find(params[:place_id])
  end

  def reservation_params
  	params.require(:reservation).permit(:date, :number_of_people)
  end
end
