require 'rest-client'
require 'open-uri'
require 'json'
#require 'colorize'
require 'io/console'
require 'ostruct'
require "active_support/core_ext/hash"
require 'whenever'

#require_relative 'lib/forecast'
#require_relative 'lib/weather'

def welcome_notice
    puts "hello man welcome to ruby weather \nget a API key from weather underground and\nset your system env variable to 'BK' and or 'NY'\nvariable(s) will be printed below as a check:"
end

class UpdateBklyn
    def key_check
        @key = ENV['WU'].to_s
        if @key == ''
            puts "error no file found in ~/.keys/master_key \n consult github.com/zackn9ne to figure out what happened"
            exit
        elsif
            puts "MASTER_KEY FOUND! Access granted!"
        end
    end

    def wipefile(city_name)
        File.open('#{city_name}.json', 'w') {}
        puts "file cleaned"
    end

    def save_file_bk
        cities = { :BK => "http://api.wunderground.com/api/#{@key}/geolookup/conditions/q/NY/manhattan.json", :NY => "http://api.wunderground.com/api/#{@key}/geolookup/conditions/q/NY/manhattan.json" }
        #save file
        wipefile("brooklyn")
        url = cities[:BK] 
        link_data = `wget #{url} -O -`
        @file_contents = File.open('brooklyn.json', 'w')
        @file_contents.write(link_data)
        puts "data saved to file"
        @file_contents.close
    end

    def read_json_file
        @file_contents = File.open('brooklyn.json', 'r')
        @json_chunk = JSON.load(@file_contents)  
    end

    def parse_json_file
        @temp = @json_chunk['current_observation']['temp_f']
        @wind = @json_chunk['current_observation']['wind_mph']
    end

    def send_values_to_md_file
        puts @temp
        file_contents = File.open('temp.md', 'w')
        file_contents.write(@temp)
        puts "temp saved to file"
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
# hold up... want_to_update
# runner

#notes
#look at json file if its too old then redownload and remake the md file
#- check the json file
#- download teh json file & make the md file
def auto_update
    #read file
    modified = File.mtime('brooklyn.json')
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
# ----run
#welcome_notice
# want_to_update
