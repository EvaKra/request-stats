def request_count(requests)
    count  = 0
    Hourly_stat.where(customer_id: requests["customerID"]).each do |stat|   
        p "valid2"
        if (stat.time - requests["timestamp"])/60/60 <= 24
                        stat.request_count = stat.request_count + 1
                        stat.save
                       count += 1
                       p count
        end
    end
end


def invalid_count(requests)

end