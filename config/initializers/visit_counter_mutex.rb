# config/initializers/visit_counter_mutex.rb

Rails.application.config.after_initialize do
  begin
    # Event 테이블이 있을 경우에만 초기화
    if ActiveRecord::Base.connection.table_exists?("events")
      initial_count = Event.maximum(:visit_count) || 0
      VisitCounterMutex.set_count(initial_count)
    end
  rescue ActiveRecord::NoDatabaseError
    # db:create 시점에는 DB가 없을 수 있음 → 무시
  end
end
