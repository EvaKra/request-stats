require "./hourly_stats"

def request_total_per_day(date)
    requests_per_day = Hourly_stat.where(date: date).sum(:request_count)
end

def invalid_total_per_day(date)
    invalid_per_day = Hourly_stat.where(date: date).sum(:invalid_count)
end

def all_requests_per_day(date)
    request_total_per_day(date) + invalid_total_per_day(date)
end

def requests_customer_per_day(customer_id, date)
    total_per_day = Hourly_stat.where(customer_id: customer_id, date: date).sum('request_count + invalid_count')
end