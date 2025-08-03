require 'net/http'
require 'uri'
require 'json'

uri = URI.parse("http://127.0.0.1:3000/events")
header = { 'Content-Type': 'application/json' }

max_threads_count = 500 #  테스트할 최대 스레드 수
step = 500 # 스레드 수 증가 단위

(step..max_threads_count).step(step) do |thread_count|
  puts "\n=== Testing with #{thread_count} threads ==="
  threads = []

  start_time = Time.now

  thread_count.times do |i|
    threads << Thread.new do
      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Post.new(uri.path, header)

      random_user_id = rand(1..50)
      request.body = { user_id: random_user_id }.to_json

      begin
        response = http.request(request)
      rescue => e
        puts "Threads ##{i+1}: Error - #{e.message}"
      end
    end
  end

  threads.each(&:join)

  elapsed = Time.now - start_time
  puts "Elapsed time for #{thread_count} threads: #{elapsed.round(2)} seconds"
end
