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
 date = "10/07/2020"
 customer_id = 1

def request_total_per_day(date)
    requests_per_day = Hourly_stat.where(created_at: date).sum(:request_count)
end

def invalid_total_per_day(date)
    invalid_per_day = Hourly_stat.where(created_at: date).sum(:invalid_count)
end

def all_requests_per_day(date)
    request_total_per_day(date) + invalid_total_per_day(date)
end

def requests_customer_per_day(customer_id, date)
    total_per_day = Hourly_stat.where(customer_id: customer_id, created_at: date).sum('request_count + invalid_count')
end





p "Total stats for the day:"
p "Total valid requests: #{request_total_per_day(date)}"
p "Total invalid requests: #{invalid_total_per_day(date)}"
p "Total number of requests: #{all_requests_per_day(date)}"
#p Hourly_stat.last.created_at.to_date 

p "Customer stats"
p "Total requests on #{date}: #{requests_customer_per_day(customer_id, date)}"
#p requests_per_day = Hourly_stat.where(customer_id: 1, created_at: date)
# p requests_per_day