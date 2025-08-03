class EventAsyncHandlerJob < ApplicationJob
  queue_as :default

  def perform(user_id, visit_count, win_status, gift_point)
    user = User.find_by(id: user_id)
    return unless user

    ApplicationRecord.transaction do
      @new_event = Event.create!(
        visit_count: visit_count,
        user: user,
        win_status: win_status
      )

      if win_status
        user.update!(point: user.point + @gift_point)

        UserPointHistory.create!(
          user: user,
          earn_point: @gift_point,
          event: @new_event
        )
      end
    end
  rescue => e
    Rails.logger.error "[EventAsyncHandlerJob] Error processing user #{user_id}: #{e.message}"
  end
end
