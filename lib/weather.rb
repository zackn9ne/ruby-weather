class Weather
    def call_api(url)
        puts "getting url at..."
        puts url
        response = RestClient.get(url)
        @json_dataset = JSON.load(response).to_json
        file = File.open('weatherdata.json', 'w')
        file.write(@json_dataset)
        puts "data saved to file"
        file.close
    end

    def wipefile(city_name)
        File.open('#{city_name}.json', 'w') {}
        puts "file cleaned"
    end

    def loadfile
        file = File.open('weatherdata.json', 'r')
        puts "file loaded"
        contents = file.read 
        @json_contents = JSON.load(contents)  
    end

    def parse(specific_json_values)
        currently = @json_contents['current_observation'] #['display_location']
        puts currently.fetch(specific_json_values)
    end

    def specific_json_values 
        parse(('temp_f'))
        parse(('relative_humidity'))
        parse(('wind_mph'))
        #parse(('observation_location','city'))
        parse(('observation_time'))
    end
end
