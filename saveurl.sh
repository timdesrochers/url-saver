#!/opt/homebrew/bin/fish

while true; 
##
# Check if we're already running;
# If not, clear the window and show the banner.
#
	if test "$firstRun" != "no";
		clear;
		echo 'Pass "q" to quit.'; 
		set_color --bold white; 
		echo "ICBfXyAgX19fX18gIF9fICAgICBfX19fICAgICAgICAgICAgICAgICAKIC8gLyAvIC8gXyBcLyAvICAgIC8gX18vX18gX18gIF9fX19fIF9fX18KLyAvXy8gLyAsIF8vIC9fXyAgX1wgXC8gXyBgLyB8LyAvIC1fKSBfXy8KXF9fX18vXy98Xy9fX19fLyAvX19fL1xfLF8vfF9fXy9cX18vXy8gICAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAK" | base64 -d;
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
	read -p "set_color --bold bryellow; \
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
	echo $input >> ~/Documents/web-archives/url-saver/saved-urls.txt;
##
# Append input line along with date/timestamp to by-date.tsv
#
	printf $(date "+%Y%t%m%t%d%t%H:%M:%S%t%z%t%A")\t'"'$input'"'\t$(uuidgen)\r\n >> ~/Documents/web-archives/url-saver/by-date.tsv ;
##	
# Read last line of saved-urls into $last to verify write
#
	set last "$(tac ~/Documents/web-archives/url-saver/saved-urls.txt | head -n 1)";

##
# Clear and refresh console for output
#
	clear;	
	set_color --bold white;
	echo $(date);
	figlet -f smslant "URL Saver";
	set_color --bold blue; printf "Entered this: ";
	set_color normal; printf $input\n;
	sleep 1;
	set_color --bold magenta; printf "Found this: ";
	set_color normal; printf $last\n;
	if test "$last" = "$input";
		printf "- - - - - - -"\n;
		sleep 0.5;
		set_color --bold green; printf "Robot says: ";
		set_color --bold normal;
		##
		# Choose a random success message, decode, and print.
		#
		sleep 0.5;
		printf (echo $oks[(random 1 15)] | base64 -d)\n;
		printf "-"\n;
		printf '"'(fortune -s)'"'\n;
		printf "- - - - - - - - - -"\n;
		##
		# Remember we're running, for display formatting.
		#
		set firstRun no;
	else;
		echo "Some sort of error has occurred. Sorry 'bout that.";
		break;
	end;
end;
