# Shows CPU load in percentage
# Defined as: (USER + NICE + SYS) / (USER + NICE + SYS + IDLE)
# Where the variables represent the number of proccesses running for different categories
# (or waiting in the case of IDLE)
head -n1 /proc/stat \
  | awk  '{print 100*($2+$3+$4)/($2+$3+$4+$5)}' \
  | sed 's/\(.*\)\(\.[0-9]\).*/\1\2/'
