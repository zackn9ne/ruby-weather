#!/usr/bin/env ruby

require 'rest-client'
require 'open-uri'
require 'json'
require "active_support/core_ext/hash"

@@home_path = "#{ENV['HOME']}/"
@@key = ENV['WU'].to_s
@@file_path = ".rubyweather/"
@@app_path = "#{ENV['HOME']}/.rubyweather/"

def welcome_notice
    puts "hello man welcome to ruby weather \nget a API key from weather underground and\nset your system env variable to 'BK' and or 'NY'\nvariable(s) will be printed below as a check:"
end

class UpdateBklyn
    def key_check
        if @key == ''
            puts "error no file found in ~/.rubyweather/config \n consult github.com/zackn9ne to figure out what happened"
            exit
        elsif
            puts "MASTER_KEY FOUND! Access granted! \n
            using #{@@key}"
        end
    end

    def wipefile(city_name)
        @file_name = "#{city_name}.json"
        @city_datafilename_path = [@@app_path,@file_name].join
        File.open(@city_datafilename_path, 'w') {}
        puts "puts ....... \n#{@city_datafilename_path} file cleaned"
    end

    def save_file_bk
        cities = { :BK => "http://api.wunderground.com/api/#{@@key}/geolookup/conditions/q/NY/manhattan.json", :NY => "http://api.wunderground.com/api/#{@@key}/geolookup/conditions/q/NY/manhattan.json" }
        #save file
        wipefile("brooklyn")
        url = cities[:BK] 
        link_data = `wget #{url} -O -`
        @file_contents = File.open(@city_datafilename_path, 'w')
        @file_contents.write(link_data)
        puts "data written to #{@city_datafilename_path}"
        @file_contents.close
    end

    def read_json_file
        @file_contents = File.open(@city_datafilename_path, 'r')
        @json_chunk = JSON.load(@file_contents)  
    end

    def parse_json_file
        @temp = @json_chunk['current_observation']['temp_f']
        @wind = @json_chunk['current_observation']['wind_mph']
        @wind_gust = @json_chunk['current_observation']['wind_gust_mph']
        @rel = @json_chunk['current_observation']['relative_humidity']
        @conditions = @json_chunk['current_observation']['weather']
    end

    def send_values_to_md_file
        puts @temp
        puts @wind
        @info = @temp, @wind, @wind_gust, @rel, @conditions
        prompt_file = [@@app_path,"temp.md"].join
        file_contents = File.open(prompt_file, 'w')
        file_contents.write(@info)
        puts "temp saved to file: #{prompt_file}"
        file_contents.close
    end
end

# runner
def want_to_update
    puts "do you want to update? and make md file?"
    update = gets.chomp.to_s
    if update == "y"
        ub = UpdateBklyn.new
        ub.key_check
        ub.save_file_bk
        ub.read_json_file
        ub.parse_json_file
        ub.send_values_to_md_file
    else
    end
end

def forced_update
    puts "forcing update..."
    ub = UpdateBklyn.new
    ub.key_check
    ub.wipefile("brooklyn")
    ub.save_file_bk
    ub.read_json_file
    ub.parse_json_file
    ub.send_values_to_md_file
end

def reload_bash_mac
    reload = `source ~/.bash_profile`
    reload
    puts  "reloading bash"
end

# runner
def auto_update
    #read file
    modified = File.mtime("#{ENV['HOME']}/.rubyweather/brooklyn.json")
    current_time = Time.now
    puts modified
    puts current_time
    if current_time - modified > 18
        puts "your files too old i am making you referesh it"
        #want_to_update
        forced_update
        reload_bash_mac
    elsif
        puts "recent data being used"
    end
end
auto_update

def specific_json_values 
    parse(('temp_f'))
    parse(('relative_humidity'))
    parse(('wind_mph'))
    parse(('observation_location'))
    parse(('observation_time'))
end
