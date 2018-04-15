#!/bin/sh
black=$(tput setaf 0)
red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)
blue=$(tput setaf 4)
magenta=$(tput setaf 5)
cyan=$(tput setaf 6)
white=$(tput setaf 7)

normal=$(tput sgr0)

pause(){
  read -p "[Enter] para continuar..." Key
}

while true

do
      clear
          printf "\t$green==========================================\n"
          printf "\t$red                Anonymous content \n"
          printf "\t$green==========================================\n"
          printf "\t$red[t]$green        Tor + Telnet \n"
          printf "\t$red[eh]$green       Tor + Telnet+9999 Backdoor EH gateways 9999-->\n"
          printf "\t$red[nc]$green       Tor + nc-->\n"
          printf "\t$red[nmap]$green     Tor + nmap-->\n"
          printf "\t$red[ssh]$green      Tor + ssh-->\n"
          printf "\t$red[ftp]$green      Tor + ftp-->\n"
          printf "\t$red[nbt]$green      Tor + nmblookup-->\n"
          printf "\t$red[modbus_r]$green Tor + modbus read-->\n"
          printf "\t$red[modbus_w]$green Tor + modbus write-->\n"
          printf "\t$red[mqtt_sub]$green Tor + MQTT SUB-->\n"
          printf "\t$red[tor_web]$green  WebBrowser Tor-->\n"
          printf "\t$green==========================================\n"
          printf "\t$red Ingrese su opcion [*]-:"
          printf $normal
          
          read opc2
          case $opc2 in         
          
          t)
            printf "Ingrese la IP _>";
            read ip
            printf "Ingrese la Puerto _>";
            read port
            proxychains telnet $ip $port
            pause;;
          
          eh)
            printf "Ingrese la IP _>";
            read ip
            proxychains telnet $ip 9999
            pause;;
          
          
          nc)
            printf "Ingrese la IP _>";
            read ip
            printf "Ingrese la Puerto _>";
            read port
            proxychains nc $ip $port
            pause;;
          
          #Anonymous
          nmap)
          
            printf "Ingrese la IP _>";
            read ip
            proxychains nmap $ip 
            pause;;
          
          ssh)
            printf "Ingrese la IP _>";
            read ip
            printf "Ingrese USER _>";
            read user
            proxychains ssh $user@$ip  
            pause;;
          
          ftp)
            
            printf "Ingrese la IP _>";
            read ip
            proxychains ftp $ip  
            pause;;
          
          nbt)
             printf "Ingrese la IP _>";
             read ip
             proxychains nmblookup -S -U $ip -R
             pause;;
             
             
          modbus_r) #400001    1..99999 for coils    400001..499999 ana 300001
             printf "Ingrese la IP _>";
             read ip
             printf "Ingrese REG 1(coils) 300001(anal) 400001(anal) _>";
             read reg
             printf "Ingrese la cant (2 .. 1000) _>";
             read cant
             proxychains modbus read --output script/modbus-tcp/$ip.yml $ip $reg $cant
             pause;;
          
          mqtt_sub)   #shodan mqtt port:"1883"
             printf "Ingrese la IP _>";
             read ip
             printf "Ingrese el /topic  _>";
             read topic
             proxychains mosquitto_sub -h $ip -v -p 1883 -t $topic/#
             pause;;
          
          #arduino/living_room/touch_sensor/set 1
          
          mqtt_bub)   #shodan mqtt port:"1883"
             printf "Ingrese la IP _>";
             read ip
             printf "Ingrese el /topic  _>";
             read topic
             printf "Ingrese el valor  _>";
             read set
             proxychains mosquitto_pub -h $ip -v -p 1883 -t arduino/living_room/touch_sensor/set -m "0"
             pause;;
          
          tor_w)
                cd ~/Descargas/tor-browser_es-ES
                ./start*
                pause;;
          l)
          
           backIFS=$IFS
           while IFS='' read -r linea || [[ -n "$linea" ]]; do
	          echo -e "Línea: $linea"
           done < dict/user.txt
           IFS=$backIFS
           pause;;	
             
          v)
          return 0;;
        *)
          printf "Seleciona una opcion valida :)";
          pause;;          
  esac
        
done
