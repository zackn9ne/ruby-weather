ruby-weather
============

get a weather underground API key and have some fun!

+ dependancies
+ gem install rest-client
+ json gem
+ wget
+ weather underground API key http://weatherunderground.com/api (free key is fine)
+ store api key in ~/.ruby-weather/rubyweatherrc
+ be sure to source <code>source ~/.rubyweather/rubyweatherrc</code> in your bash profile as well
+ put this code in your rubyweatherrc <code>export WU="your_api_key_here"</code>
+ put the following in your bash_profile PS1 statement <code>$( ruby path_to_script/ruby-weather.rb )</code>

remove the .rb extension and chmod +x ruby-weather.

make a symlink: ln -s $PWD/ruby-weather /usr/local/bin/
enjoy

-zackn9ne
