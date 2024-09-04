class PagesController < ApplicationController
  def home
    @user = Page.get_user_form_session(session)
    puts "============"
    puts @user
    puts session[:user_email]
    puts "============"

    @rooms = [
      {
        id: 1,
        room_name: "Meeting 1",
        room_address: "Binary Base",
        seat: 3,
        room_description: "Small meeting room",
      },
      {
        id: 2,
        room_name: "Meeting 2",
        room_address: "Binary Base",
        seat: 6,
        room_description: "Medium meeting room",
      },
      {
        id: 3,
        room_name: "Territory 1",
        room_address: "Binary Base",
        seat: 5,
        room_description: "Large meeting room",
      },
      {
        id: 4,
        room_name: "Territory 2",
        room_address: "Binary Base",
        seat: 5,
        room_description: "Extra large meeting room",
      },
      {
        id: 5,
        room_name: "Territory 3",
        room_address: "Binary Base",
        seat: 5,
        room_description: "Extra large meeting room",
      },
      {
        id: 6,
        room_name: "Global",
        room_address: "Binary Base",
        seat: 30,
        room_description: "Extra large meeting room",
      },
      {
        id: 7,
        room_name: "All Nighter 1",
        room_address: "Binary Base",
        seat: 36,
        room_description: "LeSSex Area",
      },
      {
        id: 8,
        room_name: "All Nighter 2",
        room_address: "Binary Base",
        seat: 32,
        room_description: "LeSSex Area",
      },
    ]
  end
end
