class ParkingSerializer < ActiveModel::Serializer
  attributes :id, :plate, :paid, :left, :paid_at, :time, :created_at, :updated_at
end
