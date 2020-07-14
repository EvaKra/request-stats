require './seed'
require 'json'
require 'date'
require './validation'
require './request_count'

#Parsing JSON
filepath = 'requests.json'
serialized_requests = File.read(filepath)
requests = JSON.parse(serialized_requests)



def valid_json_format?(json)
    JSON.parse(json)
    return true
    rescue JSON::ParserError => e
        return false
    end
 valid_json_format?(serialized_requests)

 date = "12/07/2020"
# time = 1594302659
# p new_date = DateTime.strptime("#{time}",'%s').strftime("%d/%m/%Y")

# Hourly_stat["time"] = DateTime.strptime("#{time}",'%s').strftime("%d/%m/%Y")

# def request_total_per_day(date)
#     time = DateTime.strptime("#{time}",'%s').strftime("%d/%m/%Y")
#     requests_per_day = Hourly_stat.where(time: date).sum(:request_count)
# end


DateTime.strptime("#{1594302659}",'%s').strftime("%d/%m/%Y")
 # def is_request_valid?(requests, json)  
#     if valid_length(requests) && valid_cust_id(requests) && valid_status(requests) && not_blacklisted(requests) && valid_json_format?(json)
#        return true
#     else
#         return false
#     end
# end