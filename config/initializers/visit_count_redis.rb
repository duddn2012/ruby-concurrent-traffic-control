Rails.application.config.after_initialize do
  begin
    if ActiveRecord::Base.connection.table_exists?("events")
      max_count = Event.maximum(:visit_count) || 0
      VisitCounterRedis.set_count(max_count)
    end
  rescue ActiveRecord::NoDatabaseError
  end
end
