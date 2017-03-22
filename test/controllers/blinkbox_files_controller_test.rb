require 'test_helper'

class BlinkboxFilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @blinkbox_file = blinkbox_files(:one)
  end

  test "should get index" do
    get blinkbox_files_url, as: :json
    assert_response :success
  end

  test "should create blinkbox_file" do
    assert_difference('BlinkboxFile.count') do
      post blinkbox_files_url, params: { blinkbox_file: { expiring_date: @blinkbox_file.expiring_date, extension: @blinkbox_file.extension, name: @blinkbox_file.name, owner: @blinkbox_file.owner, size: @blinkbox_file.size, uploaded_date: @blinkbox_file.uploaded_date } }, as: :json
    end

    assert_response 201
  end

  test "should show blinkbox_file" do
    get blinkbox_file_url(@blinkbox_file), as: :json
    assert_response :success
  end

  test "should update blinkbox_file" do
    patch blinkbox_file_url(@blinkbox_file), params: { blinkbox_file: { expiring_date: @blinkbox_file.expiring_date, extension: @blinkbox_file.extension, name: @blinkbox_file.name, owner: @blinkbox_file.owner, size: @blinkbox_file.size, uploaded_date: @blinkbox_file.uploaded_date } }, as: :json
    assert_response 200
  end

  test "should destroy blinkbox_file" do
    assert_difference('BlinkboxFile.count', -1) do
      delete blinkbox_file_url(@blinkbox_file), as: :json
    end

    assert_response 204
  end
end
