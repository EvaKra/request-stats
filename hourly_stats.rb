require './seed'
require 'json'
require 'date'
require './validation'


#Parsing JSON
filepath = 'request.json'
serialized_requests = File.read(filepath)
requests = JSON.parse(serialized_requests)


#Create Hourly_stats

def is_request_valid?(requests)  
    if valid_length(requests) && valid_cust_id(requests) && valid_status(requests) && not_blacklisted(requests)
       return true
    else
        return false
    end
end

# If valid but no row exists, create and set request_count to 1?
# If valid and row exists, increment request_count by 1?

# If not valid and row for customer_id exists, increment invalid_count by 1
# If not valid and row for customer_id does not exist, create row and set invalid_count to 1


if is_request_valid?(requests)  
    Hourly_stat.create(customer_id: (requests["customerID"]), time: (requests["timestamp"])), request_count: , invalid_count:)
end
    p Hourly_stat.all


# p timestamp_request = Time.strptime(requests["timestamp"].to_s,'%s')
# p  = Time.now
# p difference = newt - old
# p difference





