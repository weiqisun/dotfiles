on is_running(appName)
	tell application "System Events" to (name of processes) contains appName
end is_running

on run {input, parameters}
	set cmd to "vim -p"
	repeat with i from 1 to length of input
		set cur to item i of input
		set cmd to cmd & " " & quote & POSIX path of cur & quote
	end repeat
	
	set isRunning to is_running("iTerm2")
	tell application "iTerm"
		if isRunning then
			if not (exists current window) then
				create window with profile "Default"
			else
				tell current window
					create tab with profile "Default"
				end tell
			end if
		end if

		activate
		tell current window
			tell current session
				write text cmd
			end tell
		end tell
	end tell
end run
