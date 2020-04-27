# Shows the amount of RAM currently in use

free -h --giga | awk '$1 ~ /Mem/ {print $3}'
