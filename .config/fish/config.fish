if status is-interactive
    # Commands to run in interactive sessions can go here
end

if [ $TMUX ]
	set -U fish_greeting
else
	function fish_greeting    
		set_color brgreen; printf "                              "
		printf " _         _.*\"\\      \n"
		set_color normal; printf "fish are friends, not food    "
		set_color brgreen; printf " \\`-._..-*`     `'*-.  \n"
		set_color 709059; printf "help"; set_color 7e7e7e; printf " a fish in need           ";
		set_color brgreen; printf "  )       .     (( "; set_color cacaca; printf "°"; set_color brgreen; printf " >  \n"
		printf "                              ";
		printf " /.'\"*--.__)_.''_.-*   \n\n"; 
		set_color normal;
	end
end 

set fish_function_path $fish_function_path "/usr/share/powerline/bindings/fish"
source /usr/share/powerline/bindings/fish/powerline-setup.fish
powerline-setup
