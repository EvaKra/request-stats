# request-stats

## Background
Customers are sending billions of requests each day that need to be
processed. Today, all incoming requests are processed regardless of
their validity, leading to slower processing. We want to filter out
invalid requests (badly formatted, containing invalid values, missing
required fields, …) but keep a history on a day-by-day basis so that
we can properly charge customers for the traffic they send.

## Stats Table
 The stats table contains:
* one entry per hour and per customer ID
* the the number of valid requests
* the number of invalid requests

## Usage
``` Ruby
ruby interface.rb #will prompt for customer ID and date and will return stats for a specific customer on a specific day 
```
