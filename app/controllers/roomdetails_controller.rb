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
      {id: 1, name: "MEETING 1", maxSeat: 3,},
      {id: 2, name: "MEETING 2", maxSeat: 6,},
      {id: 3, name: "TERRITORY 1", maxSeat: 5,},
      {id: 4, name: "TERRITORY 2", maxSeat: 6,},
      {id: 5, name: "TERRITORY 3", maxSeat: 4,},
      {id: 6, name: "GLOBAL", maxSeat: 30,},
      {id: 7, name: "ALL NIGHTER 1", maxSeat: 36,},
      {id: 8, name: "ALL NIGHTER 2", maxSeat: 32,},
    ]
  end

end
