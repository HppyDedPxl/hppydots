#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '
export PATH="$HOME/.diversion/bin:$PATH"
export PATH="$PATH:$HOME/.local/bin" 
export PATH="$PATH:$HOME/.cargo/bin"

# Load modular configuration
for f in ~/.config/bashrc/*; do
	if [ ! -d $f ] ;then
		c=`echo $f | sed -e "s=.config/bashrc=.config/bashrc/custom="`
		[[ -f $c ]] && source $c || source $f
	fi
done

# Load modular configuration
for f in ~/.config/bashrc/custom/*; do
	if [ ! -d $f ] ;then
		c=`echo $f | sed -e "s=.config/bashrc=.config/bashrc/custom="`
		[[ -f $c ]] && source $c || source $f
	fi
done





