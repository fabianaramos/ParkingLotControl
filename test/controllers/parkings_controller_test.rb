require 'test_helper'

class ParkingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @parking = parkings(:one)
  end

  test 'should get the history' do
    get parking_url(@parking.plate), as: :json
    assert_response :success
  end

  test 'should create parking' do
    assert_difference('Parking.count') do
      post parkings_url, params: { parking: { plate: 'HIJ-6789' } },
                         as: :json
    end

    assert_response :created
  end

  test 'should update paid on parking' do
    put parking_pay_url(@parking.plate), as: :json
    assert_response :success
  end

  test 'should update left on parking' do
    @parking = parkings(:two)

    put parking_out_url(@parking.plate), as: :json
    assert_response :success
  end

  test 'should destroy parking' do
    assert_difference('Parking.count', -1) do
      delete parking_url(@parking.plate), as: :json
    end

    assert_response :success
  end
end
