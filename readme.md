<h1>how to use  this thing?</h1>
<ul>
<li>make a wu account</li>
<li>get a wu key, copy and paste it into the weather.rb script</li>
<li>take note of the PS1 statement in the supplied .bashrc, thats what displays your weather</li>
<li>make a chronjob every 30 minutes in order to get current weather by doing the following: </br>
$ chrontab -e</br>
0,30 * * * * your command goes here
</li>
</ul>
by Zackn9ne
