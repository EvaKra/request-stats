require './seed'
require 'json'
require 'date'
require './validation'

#Parsing JSON
filepath = 'requests.json'
serialized_requests = File.read(filepath)
requests = JSON.parse(serialized_requests)

requests.each do |request|
    if is_request_valid?(request, serialized_requests)    
        if Hourly_stat.exists?(customer_id: request["customerID"])
            count = 0
            Hourly_stat.where(customer_id: request["customerID"]).each do |stat|   
                if (request["timestamp"] - stat.time)/60/60 <= 24 && stat.date === DateTime.strptime("#{(request["timestamp"])}",'%s').strftime("%d/%m/%Y")
                    stat.request_count = stat.request_count + 1
                    stat.date = DateTime.strptime("#{(request["timestamp"])}",'%s').strftime("%d/%m/%Y")
                    stat.save
                    count += 1
                end
            end
            if count == 0
                Hourly_stat.create(customer_id: (request["customerID"]), time: (request["timestamp"]), date: DateTime.strptime("#{(request["timestamp"])}",'%s').strftime("%d/%m/%Y"), request_count: 1 , invalid_count: 0)
            end
        else
            Hourly_stat.create(customer_id: (request["customerID"]), time: (request["timestamp"]), date: DateTime.strptime("#{(request["timestamp"])}",'%s').strftime("%d/%m/%Y"), request_count: 1 , invalid_count: 0)
        end
    else
        if Hourly_stat.exists?(customer_id: request["customerID"])
            count = 0
            Hourly_stat.where(customer_id: request["customerID"]).each do |stat|   
                if (stat.time - request["timestamp"])/60/60 <= 24 && stat.date === DateTime.strptime("#{(request["timestamp"])}",'%s').strftime("%d/%m/%Y")
                    stat.invalid_count = stat.invalid_count + 1
                    stat.date = DateTime.strptime("#{(request["timestamp"])}",'%s').strftime("%d/%m/%Y")
                    stat.save
                    count += 1
                end
            end
            if count == 0
                Hourly_stat.create(customer_id: (request["customerID"]), time: (request["timestamp"]), date: DateTime.strptime("#{(request["timestamp"])}",'%s').strftime("%d/%m/%Y"), request_count: 0 , invalid_count: 1)
            end
        else
            if Customer.exists?(request["customerID"])
                Hourly_stat.create(customer_id: (request["customerID"]), time: (request["timestamp"]), date: DateTime.strptime("#{(request["timestamp"])}",'%s').strftime("%d/%m/%Y"), request_count: 0 , invalid_count: 1)
            else
                Hourly_stat.create(customer_id: "0", time: (request["timestamp"]), date: DateTime.strptime("#{(request["timestamp"])}",'%s').strftime("%d/%m/%Y"), request_count: 0 , invalid_count: 1)
            end
        end
    end   
end 

p Hourly_stat.all