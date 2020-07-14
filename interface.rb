require "./hourly_stats"
# The service must also provide
# - an endpoint to get the statistics
# - for a specific customer 
#   AND
# - a specific day
# The response must also contain the total number of requests for that day.


# puts "Which customer?"
# customer_id_query = gets.chomp

# puts "Which date DD/MM/YYYY?"
 date = "09/07/2020"
 customer_id = 3

def request_total_per_day(date)
    requests_per_day = Hourly_stat.where(date: date).sum(:request_count)
end

def invalid_total_per_day(date)
    invalid_per_day = Hourly_stat.where(date: date).sum(:invalid_count)
end

def all_requests_per_day(date)
    request_total_per_day(date) + invalid_total_per_day(date)
end

def requests_customer_per_day(customer_id, date)
    total_per_day = Hourly_stat.where(customer_id: customer_id, date: date).sum('request_count + invalid_count')
end


p "Total valid requests on #{date} : #{request_total_per_day(date)}"
p "Total invalid requests on #{date}: #{invalid_total_per_day(date)}"
p "Total number of requests on #{date}: #{all_requests_per_day(date)}"
p "Total number of requests on 10/07/2020: #{all_requests_per_day("10/07/2020")}"
#p Hourly_stat.last.created_at.to_date 

p "Total requests from customerID:#{customer_id} on #{date}: #{requests_customer_per_day(customer_id, date)}"
