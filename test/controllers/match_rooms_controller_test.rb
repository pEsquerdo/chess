require "test_helper"

class MatchRoomsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @match_room = match_rooms(:one)
  end

  test "should get index" do
    get match_rooms_url
    assert_response :success
  end

  test "should get new" do
    get new_match_room_url
    assert_response :success
  end

  test "should create match_room" do
    assert_difference('MatchRoom.count') do
      post match_rooms_url, params: { match_room: { name: @match_room.name } }
    end

    assert_redirected_to match_room_url(MatchRoom.last)
  end

  test "should show match_room" do
    get match_room_url(@match_room)
    assert_response :success
  end

  test "should get edit" do
    get edit_match_room_url(@match_room)
    assert_response :success
  end

  test "should update match_room" do
    patch match_room_url(@match_room), params: { match_room: { name: @match_room.name } }
    assert_redirected_to match_room_url(@match_room)
  end

  test "should destroy match_room" do
    assert_difference('MatchRoom.count', -1) do
      delete match_room_url(@match_room)
    end

    assert_redirected_to match_rooms_url
  end
end
