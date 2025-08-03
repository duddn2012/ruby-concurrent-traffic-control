require "test_helper"

class UserPointHistoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_point_history = user_point_histories(:one)
  end

  test "should get index" do
    get user_point_histories_url, as: :json
    assert_response :success
  end

  test "should create user_point_history" do
    assert_difference("UserPointHistory.count") do
      post user_point_histories_url, params: { user_point_history: { earn_point: @user_point_history.earn_point, event_id: @user_point_history.event_id, user_id: @user_point_history.user_id } }, as: :json
    end

    assert_response :created
  end

  test "should show user_point_history" do
    get user_point_history_url(@user_point_history), as: :json
    assert_response :success
  end

  test "should update user_point_history" do
    patch user_point_history_url(@user_point_history), params: { user_point_history: { earn_point: @user_point_history.earn_point, event_id: @user_point_history.event_id, user_id: @user_point_history.user_id } }, as: :json
    assert_response :success
  end

  test "should destroy user_point_history" do
    assert_difference("UserPointHistory.count", -1) do
      delete user_point_history_url(@user_point_history), as: :json
    end

    assert_response :no_content
  end
end
