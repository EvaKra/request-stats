require './seed'
require 'json'
require 'date'
require './validation'
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
        if Customer.exists?(requests["customerID"])
            p "invalid5"
            Hourly_stat.create(customer_id: (requests["customerID"]), time: (requests["timestamp"]), request_count: 0 , invalid_count: 1)
        else
            Hourly_stat.create(customer_id: "nonexistent", time: (requests["timestamp"]), request_count: 0 , invalid_count: 1)    
            p Hourly_stat.all
        end
    end
end    


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