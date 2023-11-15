# greeting that only prints once per tmux session
function fish_greeting
	if test -z "$SURPRESS_GREETING"
		set_color brgreen; printf "                              "
		printf " _         _.*\"\\      \n"
		set_color normal; printf "fish are friends, not food    "
		set_color brgreen; printf " \\`-._..-*`     `'*-.  \n"
		set_color 709059; printf "help"; set_color 7e7e7e; printf " a fish in need           ";
		set_color brgreen; printf "  )       .     (( "; set_color cacaca; printf "°"; set_color brgreen; printf " >  \n"
		printf "                              ";
		printf " /.'\"*--.__)_.''_.-*   \n\n"; 
		set_color normal;
		if test -n "$TMUX"
			and status --is-interactive			
				tmux setenv SURPRESS_GREETING 1
		end
	else 
		clear
	end
end

# in tmux change name and supress greeting
if test -z "$TMUX"
	and status --is-interactive		
		tmux new -A -s '󰈺'
end

# use the terminal compiled xterminal
set -gx TERM xterm-256color-italic

set -l fish_function_path $fish_function_path "/usr/share/powerline/bindings/fish"
if status --is-interactive
	source /usr/share/powerline/bindings/fish/powerline-setup.fish
	powerline-setup
end
