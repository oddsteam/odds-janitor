class RoomdetailsController < ApplicationController
  before_action :set_default_room, only: [:index]

  def index
    @mock_data_room = mock_data_room
    @selected_room = set_default_room 
    @selected_index = @mock_data_room.find_index { |room| room[:name] == @selected_room }
    @selected_room_id = @mock_data_room.find { |room| room[:name] == @selected_room }&.dig(:id)
  end

  private

  def set_default_room
    params[:selected_room] || "MEETING 1"
  end

  def mock_data_room
    [
      {id: 1, name: "MEETING 1", maxSeat: 3, x: 1270, y: 767.5, width: 200, height: 125},
      {id: 2, name: "MEETING 2", x: 548.9, y: 757, width: 185.5, height: 149},
      {id: 3, name: "TERRITORY 1", x: 169, y: 734.5, width: 184.7, height: 164},
      {id: 4, name: "TERRITORY 2", x: 169, y: 554.5, width: 184.7, height: 164.5},
      {id: 5, name: "TERRITORY 3", x: 93.5, y: 352.5, width: 260, height: 186.5},
      {id: 6, name: "GLOBAL", x: 93.5, y: 55.5, width: 669.5, height: 281},
      {id: 7, name: "ALL NIGHTER 1", x: 1805, y: 535, width: 570, height: 279.5},
      {id: 8, name: "ALL NIGHTER 2", x: 1805, y: 54, width: 675, height: 406.5}
    ]
  end

end
