#!/bin/bash

##############################################################################
#                     INSPECTOR OF FIREWALL AND IDS v1.0                     #
#                                                                            #
#                              By: init-0                                    #
##############################################################################

clear="$(which clear)"
sleep="$(which sleep)"
tail="$(which tail)"
snorte="$(which snort)"
ggufw="$(which gufw)"
tableip="$(which iptables)"


if [ -n "$snorte" ];then
cKsn="yes"
else
cKsn="no"
fi
if [ -n "$ggufw" ]; then
cKgu="yes"
else
cKgu="no"
fi
if [ -n "$tableip" ]; then
cKip="yes"
else
cKip="no"
fi
if [ -z "$snorte" -o -z "$ggufw" -o -z "$tableip" ]; then
clear
echo
echo "Please , install the IDS snort and/or FIREWALL netfilter (iptables AND/or gufw)"
echo; echo
echo "-------------------------------------"
echo -e "apt-get install snort\t$cKsn"
echo -e "apt-get install iptables\t$cKip"
echo -e "apt-get install gufw \t$cKgu"
echo
echo " and return to script " 
echo "-------------------------------------"
exit
fi
clear
ufw disable;
iptables --flush
iptables -t nat --flush
iptables -F
echo
sleep 3
ufw enable;
clear
echo
echo "Please open a new terminal in this folder and run the command:   snort -i <interface> -v -c /etc/snort/snort.conf >> log.txt "
echo
echo "start and enter"
read
clear
echo "Please wait ..."
sleep 5
t1m3(){
clear
tail -n24 log*
echo
sleep 15
clear
}
while true; do
ver1f1="$(du -sm log.txt | tr -d "[aA-zZ. ]")"
d1b1=`ls | grep BdS `
if [ "$ver1f1" -gt "1024" ]; then
    if [ "$d1b1" == "" ]; then
        mkdir BdS
    fi
Rlogs="$(date | tr " " "_" | tr ":" "-").tar.gz"
cat log* >> logs
tar -czvf $Rlogs logs*
rm logs*
mv $Rlogs BdS
echo " " > log*
sleep 3
z3r0=`ls BdS | wc -l`
    if [ "$z3r0" == "10" ]; then
        rm -rf BdS
    fi
fi
t1m3
clear
done;
