require "./queries"

puts "Which customer (customerID)?"
customer_id = gets.chomp

puts "Which date (DD/MM/YYYY)?"
date = gets.chomp

if Customer.exists?(customer_id)
    p "Requests from #{Customer.find(customer_id).name} (Customer_id: #{customer_id}) on #{date}: #{requests_customer_per_day(customer_id, date)}"
else
    p "Requests from non existing customers on #{date}: #{requests_customer_per_day(customer_id, date)}"
end

p "Total number of requests on #{date}: #{all_requests_per_day(date)}"
p "Valid requests on #{date}: #{request_total_per_day(date)}"
p "Invalid requests on #{date}: #{invalid_total_per_day(date)}"

