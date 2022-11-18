tell application id "com.figure53.QLab.5"
	tell front workspace
		set cueOrigName to q name of last item of (active cues as list)
		set q name of cue "SPOTVERS" to "QSpotify v1.4 by Alec Sparks, alecsparks.com"
	end tell
	
	set cueName to (characters (offset of "spotify" in cueOrigName) thru -1 of cueOrigName) as string --trim off comments
	set cueNameParts to my splitString(cueName, space)
	set cueFunction to first item of cueNameParts
	try
		if (cueFunction is "spotify:fade") then
			set vol to 0
			if ((count of cueNameParts) is 3) then
				set vol to third item of cueNameParts as number
			end if
			tell application "Spotify"
				set origVol to sound volume as number
				if ((count of cueNameParts) is 1) then
					set sound volume to 0
				else
					set dly to (second item of cueNameParts) / (((origVol - vol) ^ 2) ^ 0.5)
					if (vol is greater than origVol) then
						my fadeInBackground(vol, 1, dly)
					else if (vol is less than origVol) then
						my fadeInBackground(vol, -1, dly)
					end if
				end if
			end tell
		else if (((characters 1 thru 12 of cueFunction) as string) is "spotify:play") then
			tell application "Spotify" to play
		else if (((characters 1 thru 12 of cueFunction) as string) is "spotify:next") then
			tell application "Spotify" to next track
		else if (((characters 1 thru 12 of cueFunction) as string) is "spotify:mute") then
			tell application "Spotify" to set sound volume to 0
		else if (((characters 1 thru 12 of cueFunction) as string) is "spotify:user") or (((characters 1 thru 13 of cueFunction) as string) is "spotify:track") or (((characters 1 thru 13 of cueFunction) as string) is "spotify:album") then
			set trackName to first item of cueNameParts
			set inTime to 0
			set inContext to ""
			
			if (count of cueNameParts) is 2 then
				set inTime to second item of cueNameParts
			else if (count of cueNameParts) is 3 then
				set inTime to second item of cueNameParts
				set inContext to last item of cueNameParts
			end if
			
			tell application "Spotify"
				set v to sound volume
				set sound volume to 0
				if (count of cueNameParts) is 3 then
					play track trackName in context inContext
				else
					play track trackName
				end if
				repeat while (player position > 1 or player position is 0)
					delay 0.2
				end repeat
				set player position to inTime --time in seconds
				set sound volume to v
			end tell
		else if (((characters 1 thru 13 of cueFunction) as string) is "spotify:pause") then
			tell application "Spotify" to pause
		else if (((characters 1 thru 14 of cueFunction) as string) is "spotify:repeat") then
			if (count of cueNameParts) is 2 then
				tell application "Spotify" to set repeating to second item of cueNameParts
			end if
		else if (((characters 1 thru 14 of cueFunction) as string) is "spotify:unmute") then
			tell application "Spotify" to set sound volume to 100
		else if (((characters 1 thru 14 of cueFunction) as string) is "spotify:volume") then
			if (count of cueNameParts) is 2 then
				tell application "Spotify" to set sound volume to second item of cueNameParts
			end if
		else if (((characters 1 thru 15 of cueFunction) as string) is "spotify:shuffle") then
			if (count of cueNameParts) is 2 then
				tell application "Spotify" to set shuffling to second item of cueNameParts
			end if
		else if (((characters 1 thru 15 of cueFunction) as string) is "spotify:restart") then
			tell application "Spotify" to set player position to 0
		else if (((characters 1 thru 16 of cueFunction) as string) is "spotify:previous") then
			tell application "Spotify" to previous track
		else if (((characters 1 thru 19 of cueFunction) as string) is "spotify:setposition") then
			if (count of cueNameParts) is 2 then
				tell application "Spotify" to set player position to second item of cueNameParts
			end if
		end if
	end try
end tell

on fadeInBackground(vol, inc, dly)
	set dly to replace_chars(dly as string, ",", ".")
	do shell script "osascript -e 'tell application \"Spotify\"' -e 'repeat with i from sound volume to " & vol & " by " & inc & "' -e 'if (sound volume - i is greater than 1) or (sound volume - i is less than -2) then exit repeat' -e 'set sound volume to i' -e 'delay " & dly & "' -e 'end repeat' -e 'end tell'&> /dev/null&"
end fadeInBackground

on splitString(aString, delimiter)
	set retVal to {}
	set prevDelimiter to AppleScript's text item delimiters
	set AppleScript's text item delimiters to {delimiter}
	set retVal to every text item of aString
	set AppleScript's text item delimiters to prevDelimiter
	return retVal
end splitString

on replace_chars(this_text, search_string, replacement_string)
	set AppleScript's text item delimiters to the search_string
	set the item_list to every text item of this_text
	set AppleScript's text item delimiters to the replacement_string
	set this_text to the item_list as string
	set AppleScript's text item delimiters to ""
	return this_text
end replace_chars