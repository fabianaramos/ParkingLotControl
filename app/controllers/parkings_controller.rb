class ParkingsController < ApplicationController
  before_action :set_parking, only: %i[destroy pay out]

  def history
    @parkings = Parking.where(plate: params[:plate])

    render json: @parkings, each_serializer: ::ParkingSerializer, status: :ok
  end

  def create
    @parking = Parking.create!(parking_params)

    render json: @parking, serializer: ::ParkingSerializer, status: :created, location: @park
  end

  def destroy
    @parking.destroy!

    render json: @parking, serializer: ::ParkingSerializer, status: :ok
  end

  def pay
    @parking.update!(paid: true, paid_at: Time.now) unless @parking.paid?

    render json: @parking, serializer: ::ParkingSerializer, status: :ok
  end

  def out
    @parking.update!(left: true) unless @parking.left?

    render json: @parking, serializer: ::ParkingSerializer, status: :ok
  end

  private

  def set_parking
    @parking = Parking.find(params[:id] || params[:parking_id])
  end

  def parking_params
    params.require(:parking).permit(:plate, :time, :paid, :left)
  end
end
