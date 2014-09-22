def cast_api(city)
    puts "forecasting at..."
    puts city
    data = RestClient.get(city)
    @json = JSON.load(data).to_json
    file = File.open('forecast.json', 'w')
    file.write(@json)
    puts "forecast.json created"
    file.close
end
def loadcast
    file = File.open('forecast.json', 'r')
    puts "file load success."
    contents = file.read 
    @json_contents = JSON.load(contents)  
end
def parse_cast
    #puts @json_contents
    #  puts @json_contents[temp_f]
    # building error checking
    if currently = @json_contents['error']
        puts "error is: #{currently}"
    elsif
        currently = @json_contents['forecast']['simpleforecast']['forecastday']#['0']['high']['farenheit'] #['display_location']
        currently.each do |day|
            puts "future: #{day['period']}"
            puts "hi: #{day['high']['fahrenheit']}"
            puts "lo: #{day['low']['fahrenheit']}"
            puts day['conditions']
            puts "mph: #{day['avewind']['mph']}"
        end
    end
end
