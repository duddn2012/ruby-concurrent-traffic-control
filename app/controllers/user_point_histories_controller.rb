class UserPointHistoriesController < ApplicationController
  before_action :set_user_point_history, only: %i[ show update destroy ]

  # GET /user_point_histories
  def index
    @user_point_histories = UserPointHistory.all

    render json: @user_point_histories
  end

  # GET /user_point_histories/1
  def show
    render json: @user_point_history
  end

  # POST /user_point_histories
  def create
    @user_point_history = UserPointHistory.new(user_point_history_params)

    if @user_point_history.save
      render json: @user_point_history, status: :created, location: @user_point_history
    else
      render json: @user_point_history.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /user_point_histories/1
  def update
    if @user_point_history.update(user_point_history_params)
      render json: @user_point_history
    else
      render json: @user_point_history.errors, status: :unprocessable_entity
    end
  end

  # DELETE /user_point_histories/1
  def destroy
    @user_point_history.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_point_history
      @user_point_history = UserPointHistory.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def user_point_history_params
      params.expect(user_point_history: [ :user_id, :earn_point, :event_id ])
    end
end
