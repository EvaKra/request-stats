require './seed'
require 'json'
require 'date'
require './validation'
require './models'
require './request_count'


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


Hourly_stat.create(customer_id: 1, time: 1594332659, request_count: 1 , invalid_count: 0)
Hourly_stat.create(customer_id: 2, time: 1594302658, request_count: 1 , invalid_count: 0)
Hourly_stat.create(customer_id: 3, time: 1594302659, request_count: 1 , invalid_count: 0)

if is_request_valid?(requests)
    p "valid1"
    if Hourly_stat.exists?(customer_id: requests["customerID"])
        p "valid2"
        count = 0
        Hourly_stat.where(customer_id: requests["customerID"]).each do |stat|   
            if (stat.time - requests["timestamp"])/60/60 <= 24
                stat.request_count = stat.request_count + 1
                stat.save
                count += 1
                p count
                p "valid3"
                p Hourly_stat.all
            end
        end
        if count == 0
            Hourly_stat.create(customer_id: (requests["customerID"]), time: (requests["timestamp"]), request_count: 1 , invalid_count: 0)
        end
    else
        p "valid5"
        Hourly_stat.create(customer_id: (requests["customerID"]), time: (requests["timestamp"]), request_count: 1 , invalid_count: 0)
        p Hourly_stat.all
    end
else
    if Hourly_stat.exists?(customer_id: requests["customerID"])
        p "invalid2"
        count = 0
        Hourly_stat.where(customer_id: requests["customerID"]).each do |stat|   
            if (stat.time - requests["timestamp"])/60/60 <= 24
                stat.invalid_count = stat.invalid_count + 1
                stat.save
                count += 1
                p count
                p "invalid3"
                p Hourly_stat.all
            end
        end
        if count == 0
            Hourly_stat.create(customer_id: (requests["customerID"]), time: (requests["timestamp"]), request_count: 0 , invalid_count: 1)
        end
    else
        p "invalid5"
        Hourly_stat.create(customer_id: (requests["customerID"]), time: (requests["timestamp"]), request_count: 0 , invalid_count: 1)
        p Hourly_stat.all
    end
end    


#     if is_request_valid?(requests) Hourly_stat.exists?(requests["customerID"])
#         p "valid1"
#         Hourly_stat.all.each do |stat|
#         if stat.customer_id == requests["customerID"]
#             p "valid2"
#             if (stat.time - requests["timestamp"])/60/60 <= 24
#                 stat.request_count = stat.request_count + 1
#                 stat.save
#                 p "valid3"
#             else  
#                 Hourly_stat.create(customer_id: (requests["customerID"]), time: (requests["timestamp"]), request_count: 1 , invalid_count: 0)
#                 p "valid4"
#             end        
#         else
#             Hourly_stat.create(customer_id: (requests["customerID"]), time: (requests["timestamp"]), request_count: 1 , invalid_count: 0)                            
#         end
#     # else 
#     #     p "invalid1"
#     #     if stat.customer_id == requests["customerID"]
#     #         p "invalid2"
#     #         if (stat.time - requests["timestamp"])/60/60 <= 24
#     #             stat.invalid_count = stat.invalid_count + 1
#     #             stat.save
#     #             p "invalid3"
#     #         else  
#     #             Hourly_stat.create(customer_id: (requests["customerID"]), time: (requests["timestamp"]), request_count: 0 , invalid_count: 1)
#     #             p "invalid4"
#     #         end
#     #     else     
#     #         Hourly_stat.create(customer_id: (requests["customerID"]), time: (requests["timestamp"]), request_count: 0 , invalid_count: 1)  
#     #     end  
               
#     end    
# end





# stat = Hourly_stat.first
# p DateTime.strptime(stat.time.to_s,'%s')

#  p timestamp_request = DateTime.strptime(requests["timestamp"].to_s,'%s')
#old_time = DateTime.strptime(1594375200.to_s,'%s')
#new_time = Time.now

#p new_time - old_time
# p difference = newt - old
# p difference






# Hourly_stats.each |stat| do
#     if is_request_valid?(requests)
#         if stat.customer_id == requests["customerID"]
#             if (DateTime.strptime(stat.time.to_s,'%s') - DateTime.strptime(requests["timestamp"].to_s,'%s')) < 3600

#         end
#     end    
# end