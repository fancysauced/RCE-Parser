#!bin/bash

# Parse NMAP files for easy RCE Ports.
# Work in progress

input="$1"
output="$2"

function show_usage(){
    echo 'Usage: ./RCE-Parser.sh inputfile.nmap outputfile\n'
}

# Lame attempt at ASCII art to make it Super1337.
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
    echo 'Usage: ./RCE-Parser.sh inputfile.nmap outputfile\n'
    echo ''
    echo 'If you want to nmap specifically for these ports:'
    echo 'nmap -Pn -sS -sV --open -p 1090,1098,1099,4444,11099,47001,47002,10999,12721,7000-7004,800>
}

function rce_parser (){
    cat $input| grep -i 'Nmap scan report for \|PORT\|1090/tcp\|1098/tcp\|1099/tcp\|4444/tcp\|11099/>
}

if [ "$#" -ne 2 ]; then
    show_usage
fi
