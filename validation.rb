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

def valid_json_format?(json)
    JSON.parse(json)
    return true
    rescue JSON::ParserError => e
        return false
end

# malformed JSON
# missing one or more fields --> requests.length < 5
# with a customer ID not found in the database  Customer.exists?(requests["customerID"])
# or for a customer which is disabled Customer.find(requests["customerID"]).active != 1
# with a remote IP address which is in the blacklist Ip_blacklist.exists?(ip: (requests["remoteIP"]))
# with a user agent which is in the blacklist 
