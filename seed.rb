require './models'

# Seed customers
Customer.create(name: "Big News Media Corp", active: 1)
Customer.create(name: "Online Mega Store", active: 1)
Customer.create(name: "Nachoroo Delivery", active: 0)
Customer.create(name: "Euro Telecom Group", active: 1)


# Seed IP_blacklists
ip_blacklist = [0,2130706433,4294967295]

ip_blacklist.each do |b|
    ip_blacklist = Ip_blacklist.create(ip: b)
end

# Seed UA_blacklists
ua_blacklist = ['A6-Indexer','Googlebot-News','Googlebot']

ua_blacklist.each do |ua|
    ua_blacklist = Ua_blacklist.create(user_agent: ua)
end

# Seed Hourly_stats
# Hourly_stat.create(customer_id: 1, time: 1594332659, request_count: 1 , invalid_count: 0)
# Hourly_stat.create(customer_id: 2, time: 1594302658, request_count: 1 , invalid_count: 0)
# Hourly_stat.create(customer_id: 3, time: 1594302659, request_count: 1 , invalid_count: 0)

# p Hourly_stat.all