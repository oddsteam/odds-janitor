class ReservesController < ApplicationController
  before_action :isLogin
  before_action :set_reserve, only: %i[ show edit update destroy ]
  attr_reader :selected_date

  AVAILABLE_TIME = (8..18).to_a

  # GET /reserves or /reserves.json
  def index
    @getEmail = Reserve.get_email_form_session(session)
    @getUserId = Reserve.get_userId_form_session(session)
    @selected_date = params[:date] ? Date.parse(params[:date]) : Date.today
    @reserve = Reserve.new(date: @selected_date)
    @alert_message = ""

    dateNext3Month = Date.today + 3.month
    if @selected_date > dateNext3Month
      @selected_date = dateNext3Month
      @alert_message = "Maximum date is 3 months from now"
    elsif @selected_date < Date.today
      @selected_date = Date.today
      @alert_message = "You can't select the past date"
    end
    
    if params[:id].present?
      begin
        @reserve = Reserve.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        redirect_to reserves_path
      end
    end

    @reserves = Reserve.where(date: @selected_date).order(:start_timer)
    @this_user_bookings = Reserve.where(userId: @getUserId).where(date: @selected_date).order(:start_timer)
    @days_in_month = Date.new(@selected_date.year, @selected_date.month, -1).day
    @start_of_month = @selected_date.beginning_of_month.wday

    @rooms = [
      { id: 1, name: "Meeting 1", address: "Binary Base", seat: 3, description: "Small meeting room" },
      { id: 2, name: "Meeting 2", address: "Binary Base", seat: 6, description: "Medium meeting room" },
      { id: 3, name: "Territory 1", address: "Binary Base", seat: 5, description: "Large meeting room" },
      { id: 4, name: "Territory 2", address: "Binary Base", seat: 5, description: "Extra large meeting room" },
      { id: 5, name: "Territory 3", address: "Binary Base", seat: 5, description: "Extra large meeting room" },
      { id: 6, name: "Global", address: "Binary Base", seat: 30, description: "Extra large meeting room" },
      { id: 7, name: "All Nighter 1", address: "Binary Base", seat: 36, description: "LeSSex Area" },
      { id: 8, name: "All Nighter 2", address: "Binary Base", seat: 32, description: "LeSSex Area" },
    ]
  end

  # PATCH /reserves/update_selected_date
  def update_selected_date
    if params[:date].present?
      @selected_date = Date.parse(params[:date])
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("calendar", partial: "calendar", locals: { selected_date: @selected_date, days_in_month: Date.new(@selected_date.year, @selected_date.month, -1).day, rooms: @rooms })
        end
        format.html { redirect_to reserves_path(date: @selected_date) }
      end
    else
      head :unprocessable_entity
    end
  rescue ArgumentError => error.message
    Rails.logger.error "Invalid date format: #{params[:date]}"
    head :unprocessable_entity
  end

  # GET /reserves/1 or /reserves/1.json
  def show
  end

  # GET /reserves/new
  def new
    @reserve = Reserve.new
  end

  # GET /reserves/1/edit
  def edit
  end

  # POST /reserves or /reserves.json
  def create
    user_id = Reserve.get_userId_form_session(session)
    @reserve = Reserve.new(reserve_params.merge(userId: user_id))

    respond_to do |format|
      if @reserve.save
        format.html { redirect_to reserves_path, notice: "Reserve was successfully created." }
        format.json { render json: { status: 'success', notice: "Reserve was successfully created." }, status: :created }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: { status: 'error', errors: @reserve.errors }, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reserves/1 or /reserves/1.json
  def update
    uid = Page.get_userId_form_session(session)
    respond_to do |format|
      if @reserve.update(reserve_params.merge(userId: uid))
        format.html { redirect_to reserves_path, notice: "Reserve was successfully updated." }
        format.json { render :show, status: :ok, location: @reserve }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @reserve.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reserves/1 or /reserves/1.json
  def destroy
    @reserve.destroy!

    respond_to do |format|
      format.html { redirect_to reserves_url, notice: "Reserve was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_reserve
    @reserve = Reserve.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def reserve_params
    params.require(:reserve).permit(:date, :start_timer, :end_timer, :note, :roomId)
  end
end