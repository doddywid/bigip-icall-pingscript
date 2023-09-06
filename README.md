This repo provide BIGIP icall script for pingscript.
Pingscript do the following
- periodically:
  - ping a target
  - check status of an interface
- depending on both results above, either do enable/disable specific interface

<br>
To setup pingscript:

1. Copy content of pingscript.sh to /config/pingscript.sh. Modify ping target and interface in this file accordingly
2. Enable script execution:

         #chmmod +x /config/pingscript.sh

4. Load pingscript & pingscript_handler to config
 
         (tmos)# load sys config from-terminal merge


<br>
Structure of an icall:
	
 	iCall handler (periodic in this case) --> iCall script --> the actual shell script in /config folder
