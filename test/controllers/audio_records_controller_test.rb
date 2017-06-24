require 'test_helper'

class AudioRecordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @audio_record = audio_records(:one)
  end

  test "should get index" do
    get audio_records_url
    assert_response :success
  end

  test "should get new" do
    get new_audio_record_url
    assert_response :success
  end

  test "should create audio_record" do
    assert_difference('AudioRecord.count') do
      post audio_records_url, params: { audio_record: { b64field: @audio_record.b64field, user_id: @audio_record.user_id } }
    end

    assert_redirected_to audio_record_url(AudioRecord.last)
  end

  test "should show audio_record" do
    get audio_record_url(@audio_record)
    assert_response :success
  end

  test "should get edit" do
    get edit_audio_record_url(@audio_record)
    assert_response :success
  end

  test "should update audio_record" do
    patch audio_record_url(@audio_record), params: { audio_record: { b64field: @audio_record.b64field, user_id: @audio_record.user_id } }
    assert_redirected_to audio_record_url(@audio_record)
  end

  test "should destroy audio_record" do
    assert_difference('AudioRecord.count', -1) do
      delete audio_record_url(@audio_record)
    end

    assert_redirected_to audio_records_url
  end
end
