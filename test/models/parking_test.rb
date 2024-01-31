require 'test_helper'

class ParkTest < ActiveSupport::TestCase
  test 'plate presence validation' do
    parking = Parking.new(plate: nil)
    assert_not parking.valid?
    assert_includes parking.errors[:plate], "can't be blank"
  end

  test 'plate format validation' do
    parking = Parking.new(plate: '123-ABCD')
    assert_not parking.valid?
    assert_includes parking.errors[:plate], 'is invalid'

    parking = Parking.new(plate: 'ABC-1234')
    assert parking.valid?
  end

  test 'park can be left validation' do
    parking = Parking.new(plate: 'ABC-1234', paid: false, left: true)
    assert_not parking.valid?
    assert_includes parking.errors[:paid], 'must be true before leaving'

    parking = Parking.new(plate: 'ABC-1234', paid: true, left: true)
    assert parking.valid?
  end

  test '#time returns correct time for paid parking' do
    created_at = 2.hours.ago
    paid_at = 1.hour.ago
    parking = Parking.new(plate: 'ABC-1234', paid: true, created_at: created_at, paid_at: paid_at)

    expected_time = "#{((paid_at - created_at) / 60).to_i} minutes"
    assert_equal expected_time, parking.time
  end

  test '#time returns correct time for unpaid parking' do
    created_at = 2.hours.ago
    parking = Parking.new(plate: 'ABC-1234', created_at: created_at)

    expected_time = "#{((Time.now - created_at) / 60).to_i} minutes"
    assert_equal expected_time, parking.time
  end
end
