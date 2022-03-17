#!/bin/bash
RRD="/opt/ips_stat/ips_attack"

RRDPNGD="/opt/observium/html/img/ips_day.png"
RRDPNGW="/opt/observium/html/img/ips_week.png"
RRDPNGM="/opt/observium/html/img/ips_month.png"

ATTACK_BL=`snmpwalk -cHelloIPS-privetTE -v2c ips1.psu.ru 'NET-SNMP-EXTEND-MIB::nsExtendOutputFull."network.protection.stats"' | grep "attacks.blocked = " | awk '{ print($3); }'`
ATTACK_DET=`snmpwalk -cHelloIPS-privetTE -v2c ips1.psu.ru 'NET-SNMP-EXTEND-MIB::nsExtendOutputFull."network.protection.stats"' | grep "attacks.detected = " | awk '{ print($3); }'`
ATTACK_NBL=$(($ATTACK_DET-$ATTACK_BL))

echo "${N}" » log
echo "${ATTACK_BL}" » log
echo "${ATTACK_DET}" » log
echo "${ATTACK_NBL}" » log

rrdtool update $RRD N:${ATTACK_BL}:${ATTACK_NBL}

# daily graph
GRAPHCMD=(
graph ${RRDPNGD} —start -1d —width 420 —height 100
-c CANVAS#00000000 -c BACK#00000000 -c FONT#999999 —font WATERMARK:1: —border 0
—right-axis 0.1:0
DEF:attack_bl=${RRD}:attack_bl:MAX
DEF:attack_nbl=${RRD}:attack_nbl:MAX
CDEF:attack_nblr=attack_nbl,-1,*
AREA:attack_bl#FF0000:blocked_atack
AREA:attack_nblr#7777FF:not_blocked_attack
LINE1:attack_bl#990000 LINE1:attack_nblr#0000FF)

rrdtool "${GRAPHCMD[@]}"

GRAPHCMD=(
graph ${RRDPNGW} —start -7d —width 420 —height 100
-c CANVAS#00000000 -c BACK#00000000 -c FONT#999999 —font WATERMARK:1: —border 0
—right-axis 0.1:0
DEF:attack_bl=${RRD}:attack_bl:MAX
DEF:attack_nbl=${RRD}:attack_nbl:MAX
CDEF:attack_nblr=attack_nbl,-1,*
AREA:attack_bl#FF0000:blocked_atack
AREA:attack_nblr#7777FF:not_blocked_attack
LINE1:attack_bl#990000 LINE1:attack_nblr#0000FF)

rrdtool "${GRAPHCMD[@]}"

GRAPHCMD=(
graph ${RRDPNGM} —start -31d —width 420 —height 100
-c CANVAS#00000000 -c BACK#00000000 -c FONT#999999 —font WATERMARK:1: —border 0
—right-axis 0.1:0
DEF:attack_bl=${RRD}:attack_bl:MAX
DEF:attack_nbl=${RRD}:attack_nbl:MAX
CDEF:attack_nblr=attack_nbl,-1,*
AREA:attack_bl#FF0000:blocked_atack
AREA:attack_nblr#7777FF:not_blocked_attack
LINE1:attack_bl#990000 LINE1:attack_nblr#0000FF)

rrdtool "${GRAPHCMD[@]}"
