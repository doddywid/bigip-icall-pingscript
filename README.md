This repo provide BIGIP icall script for pingscript.
Pingscript do the following
- periodically:
  - ping a target
  - check status of an interface
- depending on both results above, either do enable/disable specific interface


<br>
Structure of an icall:
	
 	iCall handler (periodic in this case) --> iCall script --> the actual shell script in /config folder
