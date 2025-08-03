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

    ApplicationRecord.transaction do
      next_count = VisitCounter.next_count

      @gift_point = 100
      @winning_order_number = 100

      win_status = next_count % @winning_order_number == 0

      @new_event = Event.new(
        visit_count: next_count,
        user: user,
        win_status: win_status
      )

      unless @new_event.save
        raise ActiveRecord::Rollback
      end

      if @new_event.win_status
        unless user.update(point: user.point + @gift_point)
          raise ActiveRecord::Rollback
        end

        UserPointHistory.create!(
          user: user,
          earn_point: @gift_point,
          event: @new_event
        )
      end
    end

    # 트랜잭션 밖에서 응답 처리
    if @new_event.persisted?
      render json: @new_event, status: :created, location: @new_event
    else
      render json: @new_event.errors, status: :unprocessable_entity
    end
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
      @event = Event.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.expect(event: [ :user_id, :visit_count, :win_status ])
    end
end
