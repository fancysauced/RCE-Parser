#!/bin/bash

# Parse NMAP files for easy RCE Ports
# Work in progress

input="$1"
output="$2"

function show_usage(){
    echo 'Usage: ./RCE-Parser.sh inputfile.nmap outputfile'
    echo ''
}
#If you want to nmap specifically for these ports:
#nmap -Pn -sS -sV --open -p 1090,1098,1099,4444,11099,47001,47002,10999,12721,7000-7004,8000-8003,9000-9003,9503,7070,7071,45000,45001,8686,9012,50500,4848,11111,4444,4445,4786,5555,5556,8880,8088,6379,2375,8983,8383,4990,9000,8500,6066,5000,8080,3300,6129,6970 -iL targets.txt -oA rce-ports


# Lame attempt at ASCII art to make it Super1337
function ascii_art(){
    echo '+--------------------------------+'
    echo '|======[ RCE-Cream-Parcer ]======|'
    echo '+--------------------------------+'
    echo '|| \|N\|M\|A\|P\||/D|/A|/T|/A|/ ||'
    echo '|.  .  .  .  .  ..  .  .  .  .  .|'
    echo '|.  .  .  .  .  ..  .  .  .  .  .|'
    echo '|.  .  .  .  .  ..  .  .  .  .  .|'
    echo '|.  .  .  ==============  .  .  .|'
    echo '|.  .  .    \-Parser-/    .  .  .|'
    echo '|.  .  .     \______/     .  .  .|'
    echo '|.  .  .        []        .  .  .|'
    echo '|.  .  .        ..        .  .  .|'
    echo '|.  .  .       _.._       .  .  .|'
    echo '|.  .  .      (_RCE)      .  .  .|'
    echo '|.  .  .     (Cream_)     .  .  .|'
    echo '|.  .  .    (________)    .  .  .|'
    echo '|.  .  .     \/\/\/\/     .  .  .|'
    echo '|.  .  .      \/\/\/      .  .  .|'
    echo '|.  .  .       \/\/       .  .  .|'
    echo '|.  .  .        \/        .  .  .|'
    echo '+--------------------------------+'
    echo '| https://github.com/fancysauced |'
    echo '+--------------------------------+'
    echo ''
}


function show_usage(){
    echo 'Usage: ./RCE-Parser.sh inputfile.nmap outputfile'
    echo ''
}


function processing(){
    echo ''
}


function rce_parser (){
    echo 'Processing data...'
    cat $input | grep -i 'Nmap scan report for \|PORT\|1090/tcp\|1098/tcp\|1099/tcp\|4444/tcp\|11099/tcp\|47001/tcp\|47002/tcp\|10999/tcp\|12721/tcp\|7000/tcp\|7001/tcp\|7002/tcp\|7003/tcp\|7004/tcp\|8000/tcp\|8001/tcp\|8002/tcp\|8003/tcp\|9000/tcp\|9001/tcp\|9002/tcp\|9003/tcp\|9503/tcp\|7070/tcp\|7071/tcp\|45000/tcp\|45001/tcp\|8686/tcp\|9012/tcp\|50500/tcp\|4848/tcp\|11111/tcp\|4444/tcp\|4445/tcp\|4786/tcp\|5555/tcp\|5556/tcp\|8880/tcp\|8088/tcp\|6379/tcp\|2375/tcp\|8983/tcp\|8383/tcp\|4990/tcp\|8500/tcp\|6066/tcp\|5000/tcp\|8080/tcp\|3300/tcp\|6129/tcp\|6970/tcp\|weblogic\|jdwp\|jmx\|glassfish\|jboss\|redis\|sap\|dameware\|coldfusion\|jenkins\|docker\|flink\|spark\|hadoop\|manageengine\|hashicorp\|websphere\|solr\|portainer\|java-rmi\|java rmi\|rmi-registry\|hp data protector\|cisco smart install\|cisco unified communications manager\|tomcat\|Service Info:' | sed 's/Nmap scan report for /\n/g' | grep -vi 'filtered\|closed\|#\|SF:\|SF-\|unrecognized\|incorrect\|Warning:\|Host is' | grep -B2 '/tcp' > $output
    echo 'Done'
}

if [ "$#" -ne 2 ]; then
    ascii_art
    show_usage
else
    ascii_art
    rce_parser
fi
