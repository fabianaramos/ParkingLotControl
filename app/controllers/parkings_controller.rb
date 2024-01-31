class ParkingsController < ApplicationController
  def index
    @parkings = Parking.where(plate: params[:plate].upcase)

    render json: @parkings, each_serializer: ::ParkingSerializer, status: :ok
  end

  def create
    @parking = Parking.create!(parking_params)

    render json: @parking, serializer: ::ParkingSerializer, status: :created
  end

  def destroy
    @parkings = Parking.where(plate: params[:plate].upcase)
    @parkings.destroy_all

    render json: @parkings, each_serializer: ::ParkingSerializer, status: :ok
  end

  def pay
    @parking = Parking.find_by!(paid: false, plate: params[:parking_plate].upcase)
    @parking.update!(paid: true, paid_at: Time.now)

    render json: @parking, serializer: ::ParkingSerializer, status: :ok
  end

  def out
    @parking = Parking.find_by!(left: false, plate: params[:parking_plate].upcase)
    @parking.update!(left: true) unless @parking.left?

    render json: @parking, serializer: ::ParkingSerializer, status: :ok
  end

  private

  def parking_params
    params.require(:parking).permit(:time, :paid, :left).merge(plate: params[:parking][:plate].upcase)
  end
end
