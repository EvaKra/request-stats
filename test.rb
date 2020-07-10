# invalid request
# {
#      "customerID":1,
#     "tagID":2,
#      "userID":"aaaaaaaa-bbbb-cccc-1111-222222222222",
#      "remoteIP":"4294967295",
#     "timestamp":1594302659
#  }

# {
#      "customerID":1,
#      "tagID":2,
#      "userID":"aaaaaaaa-bbbb-cccc-1111-222222222222",
#      "remoteIP":"123.234.56.78",
#      "timestamp":1594302659
#  }

numbers = [1,9,12,4,54,545,6,7,8]

numbers.each do |number|
    if number < 10 
        if number < 8
            p "fab"
        else
            p "loose"
        end
    else
        p "do nothing"
    end
end