require "rails_helper"

RSpec.describe PagesController, type: :controller do
  before(:each) do
    session[:user_email] = "fake@fake.com"
    session[:user_id] = "ForTestOnly"
    session[:refresh_token] = "FakeR-efre-shTo-ken"
  end

  describe "GET #home" do
    it "assigns @user" do
      allow(Page).to receive(:get_user_form_session).and_return(session[:user_email])
      get :home
      expect(session[:user_email]).not_to be_nil
    end

    it "assigns @rooms" do
      get :home
      expect(assigns(:rooms)).not_to be_nil
      expect(assigns(:rooms)).to be_an Array
      expect(assigns(:rooms).size).to eq(8)
    end

    it "renders the home template" do
      get :home
      expect(response).to render_template("home")
    end
  end

  describe "@rooms" do
    before { get :home }

    it "has the correct room attributes" do
      room = assigns(:rooms).first
      expect(room).to have_key(:id)
      expect(room).to have_key(:room_name)
      expect(room).to have_key(:room_address)
      expect(room).to have_key(:seat)
      expect(room).to have_key(:room_description)
    end

    it "has the correct room values" do
      rooms = assigns(:rooms)
      expect(rooms[0][:id]).to eq(1)
      expect(rooms[0][:room_name]).to eq("Meeting 1")
      expect(rooms[0][:room_address]).to eq("Binary Base")
      expect(rooms[0][:seat]).to eq(3)
      expect(rooms[0][:room_description]).to eq("Small meeting room")

      # You can add more expectations for the other rooms
    end
  end
end
