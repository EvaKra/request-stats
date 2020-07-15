def valid_length(requests)
   requests.length == 5
end

def valid_cust_id(requests)
    Customer.exists?(requests["customerID"])
end

def valid_status(requests)
    Customer.find(requests["customerID"]).active == 1
end

def not_blacklisted(requests)
    !Ip_blacklist.exists?(ip: (requests["remoteIP"]))
end

def not_blacklisted_ua(requests)
    !Ua_blacklist.exists?(user_agent: (requests["userID"]))
end

def valid_json_format?(requests)
    JSON.parse(requests)
    return true
    rescue JSON::ParserError => e
        return false
end

def is_request_valid?(requests, serialized_requests)  
    if valid_length(requests) && valid_cust_id(requests) && valid_status(requests) && not_blacklisted(requests) && valid_json_format?(serialized_requests) && not_blacklisted_ua(requests)
       return true
    else
        return false
    end
end