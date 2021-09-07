exec picom &
autorandr --change && ~/.fehbg

if [ $HOSTNAME = "puzzle" ]; then
	xmodmap -e 'clear Lock'
	xmodmap -e 'keycode 0x42=Escape' 
fi

exec dwm
