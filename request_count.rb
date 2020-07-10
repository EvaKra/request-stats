def request_count_increment(requests)
    sum  = 0
    Hourly_stat.where(customer_id: requests["customerID"]).each do |stat|   
        p "valid2"
        if (stat.time - requests["timestamp"])/60/60 <= 24
                        stat.request_count = stat.request_count + 1
                        stat.save
                       sum += 1
                       p sum
        end
    end
end