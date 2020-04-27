# Shows CPU load in percentage
# Shows average load over the last minute.
# Note: I normalise the load per number of PCU.
# That means a fully used quad-core CPU will have 100% instead of 400%
head -n1 /proc/loadavg \
        | awk  -vncpu=$(grep 'model name' /proc/cpuinfo | wc -l) '{printf( "%5.1f\n", 100*$1/ncpu)}'
