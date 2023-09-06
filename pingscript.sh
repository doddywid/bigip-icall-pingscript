#!/bin/bash
target=10.1.1.1
interface=1.3

pingres=`ping -c 3 -i 0.5 -q $target`
pingres=`echo $pingres | sed -nr 's/.*( |^)([0-9]+)% packet loss.*/\2/p'`
echo $pingres

status=`tmsh show net interface $interface | grep $interface`
status=`echo $status | awk 'BEGIN { FS = " "}; {print $2}'`
echo $status

if [ "$pingres" == "0" ] && [ "$status" == "disabled" ] ; then
   logger -p local0.info "DUALHOMING - ping success, interface $interface $status, do nothing"
elif [ "$pingres" == "0" ] && [ "$status" != "disabled" ] ; then
   logger -p local0.info "DUALHOMING - ping success, interface $interface $status, disabling interface $interface"
   tmsh modify net interface $interface disabled
   tmsh save /sys config
elif [ "$pingres" != "0" ] && [ "$status" == "disabled" ] ; then
   logger -p local0.info "DUALHOMING - ping lost, interface $interface $status, enabling interface $interface"
   tmsh modify net interface $interface enabled
   tmsh save /sys config
elif [ "$pingres" != "0" ] && [ "$status" != "disabled" ] ; then
   logger -p local0.info "DUALHOMING - ping lost, interface $interface $status, do nothing"
fi
