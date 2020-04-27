# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# Add new directories to PATH
# Include user's private bins
ADD_TO_PATH=( "$HOME/bin" "$HOME/.local/bin" /sbin /usr/sbin /usr/local/sbin )
# Add language-specific binaries
ADD_TO_PATH+=( "$HOME/.cargo/bin" /usr/local/go/bin "$HOME/perl5/bin" )
# Add snap binaries to path
ADD_TO_PATH+=( /snap/bin /usr/sbin )
# Add anaconda installation to path
ADD_TO_PATH+=( /opt/anaconda3/bin )
for dir in ${ADD_TO_PATH[@]}; do
    if [ -d $dir ] ; then
        PATH="$PATH:$dir"
    fi
done
export PATH
# Perl stuff...
#PERL5LIB="$HOME/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
#PERL_LOCAL_LIB_ROOT="$HOME/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
#PERL_MB_OPT="--install_base \"$HOME/perl5\""; export PERL_MB_OPT;
#PERL_MM_OPT="INSTALL_BASE=$HOME/perl5"; export PERL_MM_OPT;

