require "application_system_test_case"

class MatchRoomsTest < ApplicationSystemTestCase
  setup do
    @match_room = match_rooms(:one)
  end

  test "visiting the index" do
    visit match_rooms_url
    assert_selector "h1", text: "Match Rooms"
  end

  test "creating a Match room" do
    visit match_rooms_url
    click_on "New Match Room"

    fill_in "Name", with: @match_room.name
    click_on "Create Match room"

    assert_text "Match room was successfully created"
    click_on "Back"
  end

  test "updating a Match room" do
    visit match_rooms_url
    click_on "Edit", match: :first

    fill_in "Name", with: @match_room.name
    click_on "Update Match room"

    assert_text "Match room was successfully updated"
    click_on "Back"
  end

  test "destroying a Match room" do
    visit match_rooms_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Match room was successfully destroyed"
  end
end
