ruby-weather
============

get a weather underground API key and have some fun!

+ dependancies
+ `$gem install rest-client, json`
+ `$ apt-get install wget`

.rubyweather dotfile file syntax (put in app root)
```
configFile:
 key: 796a8e108c09f410
 city: brooklyn
 state: NY
 ```

+ weather underground API key http://weatherunderground.com/api (free key is fine)
- remove the .rb extension and chmod +x ruby-weather.

make a symlink: ln -s $PWD/ruby-weather /usr/local/bin/
enjoy

-zackn9ne
