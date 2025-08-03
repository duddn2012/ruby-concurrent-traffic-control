class EventsController < ApplicationController
  before_action :set_event, only: %i[ show update destroy ]

  # GET /events
  def index
    @events = Event.all

    render json: @events
  end

  # GET /events/1
  def show
    render json: @event
  end

  # POST /events
  def create
    user = User.find(params[:user_id])

    next_count = VisitCounterRedis.next_count

    @gift_point = 100
    @winning_order_number = 100
    win_status = next_count % @winning_order_number == 0

    EventAsyncHandlerJob.perform_later(
      user.id,
      next_count,
      win_status,
      @gift_point
    )

    render json: { win_status: win_status }, status: :ok
  end

  # PATCH/PUT /events/1
  def update
    if @event.update(event_params)
      render json: @event
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  # DELETE /events/1
  def destroy
    @event.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params.require(:id))
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(event: [ :user_id, :visit_count, :win_status ])
    end
end
