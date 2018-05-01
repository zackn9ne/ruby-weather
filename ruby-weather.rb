#!/usr/bin/env ruby

require 'rest-client'
require 'open-uri' #a ruby conterpart
require 'json'
#require "active_support/core_ext/hash"

#globals
@@home_path = "#{ENV['HOME']}/" 
@@key = ENV['WU'].to_s #=> echo $WU put this in the path
@@app_path = "#{ENV['HOME']}/code/ruby-weather/"

class UpdateBklyn
    def key_check
        if @key == ''
            puts "no alias in system for $WU (api-key)"
            exit
        elsif
            puts "MASTER_KEY FOUND! Access granted! \n
            using #{@@key}"
        end
    end

    def download
      puts "what is your city? "
      city = gets
      city = city.chomp

      puts "what is your state 2LETTER? "
      state = gets
      state = state.chomp
      
        cities = { :BK => "http://api.wunderground.com/api/#{@@key}/geolookup/conditions/q/NY/brooklyn.json", :NY => "http://api.wunderground.com/api/#{@@key}/geolookup/conditions/q/NY/manhattan.json" }
        #save file
        url = cities[:BK] 
        puts "getting #{url}"
        link_data = `wget -q #{url} -O #{@@app_path}brooklyn.json`
        puts "running command..."
        link_data
    end

    def read_json_file
        jsonfile = [@@app_path, "brooklyn.json"].join
        @file_contents = File.open(   jsonfile, 'r') #=> brooklyn.json
        @json_chunk = JSON.load(@file_contents)  
    end

    def parse_json_file
        @temp = @json_chunk['current_observation']['temp_f']
        @wind = @json_chunk['current_observation']['wind_mph']
        @wind_gust = @json_chunk['current_observation']['wind_gust_mph']
        @rel = @json_chunk['current_observation']['relative_humidity']
        @conditions = @json_chunk['current_observation']['weather']
    end

    def send_values_to_output
        @info = [@temp, @wind, @wind_gust, @rel, @conditions].to_s
        puts @info
#        spawn({'BLAH' => 'qerty'}, "echo $BLAH")
        ENV['BLAH'] = 'qwerty'
#        `echo $BLAH`
        command = "echo \"export WEATHER='cambriadge #{@info}'\">> ~/.bashrc && source ~/.bashrc"
        exec command
        
    end

end



def forced_update
    puts "downloading..."
    ub = UpdateBklyn.new
    ub.key_check
    ub.download
    ub.read_json_file
    ub.parse_json_file
    ub.send_values_to_output
end

def spit_cached_data
    puts "running cached..."
    uc = UpdateBklyn.new
    uc.key_check
    #uc.save_file_bk
    uc.read_json_file
    uc.parse_json_file
    uc.send_values_to_output
end

# runner
def auto_update
    #read file
    modified = File.mtime("#{@@app_path}brooklyn.json")
    current_time = Time.now
    if current_time - modified > 18
        #puts "your files too old i am making you referesh it"
        forced_update
    elsif
        spit_cached_data
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
