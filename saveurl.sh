#!/opt/homebrew/bin/fish

while true; 
##
# Check if we're already running;
# If not, clear the window and show the banner.
#
	if test "$firstRun" != "no";
		clear;
		echo 'Pass "q" to quit.'; 
		figlet -f smslant "URL Saver";
	end;
##	
# Load list of "success" messages;
# Minimally obfuscated for fun.
#
	set oks Q2hlY2tzIG91dCEK \
		TG9va3MgZ29vZCEK \
		VGhhbmsgeW91IQo= \
		U2VlbXMgT0sgdG8gbWUuCg== \
		SSBhcHByb3ZlLgo= \
		Q29vbCwgY29vbCwgY29vbC4K \
		SG1waCwgcmVhbGx5Pwo= \
		T2gsIGludGVyZXN0aW5nIQo= \
		RHVkZS4uLiB0aGF0J3MgY3JhenkuCg== \
		QXJlIHlvdSByZWFsbHkgZ29pbmcgdG8gbmVlZCB0aGlzIGFnYWluPwo= \
		RmVlZCBtZSEhCg== \
		SSByZXBvcnQgc3VjY2Vzcy4K \
		Q2FuJ3Qgc2VlIGFueXRoaW5nIHdyb25nIHdpdGggdGhhdC4K \
		WW91IGV2ZXIgd29uZGVyIGFib3V0IGVudHJvcHk/Cg== \
		RXZlcnl0aGluZyB3b3JrZWQsIEkgdGhpbmsuCg== ;
##
# Specify readline prompt string & style.
#
	read -p "set_color green; \
		printf 'Enter URL'; \
		set_color normal; \
		printf ' > '" input;
##
# Break & terminate when "q" is entered.
# This is _important_ because for some reason fish
# doesn't listen to ctrl-C for SIGINT when `read`ing?
#
	if test "$input" = "q";
		set firstRun;
		break;
	end;
##
# Write/append input line to saved-urls.txt
#
	echo $input >> ~/saved-urls.txt;

##	
# Read last line of saved-urls into $last to verify write
#
	set last "$(tac ~/saved-urls.txt | head -n 1)";

##
# Clear and refresh console for output
#
	clear;	
	set_color --bold white; echo $(date);
	figlet -f smslant "URL Saver";
	set_color --bold blue; printf "Entered this: ";
	set_color --italics normal; printf $input\n;
	set_color --bold magenta; printf "Checking: ";
	set_color --italics normal; printf $last\n;
	if test "$last" = "$input";
		set_color --bold green; printf "Robot says: ";
		set_color --italics normal;
		##
		# Choose a random success message, decode, and print.
		#
		printf (echo $oks[(random 1 15)] | base64 -d)\n;
		printf "- - - - - - - - - - - - - - - - - - - - - - -"\n;
		##
		# Remember we're running, for display formatting.
		#
		set firstRun no;
	else;
		echo "Some sort of error has occurred. Sorry 'bout that.";
		break;
	end;
end;
