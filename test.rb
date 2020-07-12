require 'json'




#Parsing JSON
filepath = 'request.json'
serialized_requests = File.read(filepath)

requests = JSON.parse(serialized_requests)

p requests[0]