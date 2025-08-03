class VisitCounter
  @count = 0
  @mutex = Mutex.new

  class << self
    def next_count
      @mutex.synchronize do
        @count += 1
      end
    end

    def current_count
      @mutex.synchronize { @count }
    end

    def set_count(value)
      @mutex.synchronize { @count = value }
    end
  end
end
