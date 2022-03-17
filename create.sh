NOW=`date +%s`

PARAMS="--start ${NOW} —step 60 DS:attack_bl:COUNTER:120:U:U DS:attack_nbl:COUNTER:120:U:U RRA:MAX:0.5:1:20160 RRA:MAX:0.5:1:20160"

rrdtool create ips_attack ${PARAMS}