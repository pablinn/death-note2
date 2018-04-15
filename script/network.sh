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
  echo -n ''	
  read -p "-->[Enter] ..." Key
}


val='0'
chek(){
	if [ -x /usr/bin/$1 ] || [ -x /usr/sbin/$1 ] || [ -x /usr/local/bin/$1 ] || [ -x /bin/$1 ]; then
          echo "El programa \"$1\" está instalado."
          val='1'
           else
          echo "No está instalado \"$1\"."
          val='0'
          
          fi
          
     
}

say(){

if [ $val == '0' ]
             then
               echo -n $caption
               echo -n $simbol
             else
               echo -n $caption | iconv -f utf-8 -t iso-8859-1|festival --tts
               echo -n $simbol
             fi     
}   


#soporte para voz comentar si no se desea esta capacidad
#chek festival
 

while true

do
clear     
          printf "\t$green==========================================\n"
          printf "\t$red                Anonymous content \n"
          printf "\t$green==========================================\n" 
          printf "\t$red[ip_p]$green     IP publica\n"
          printf "\t$red[geo_p]$green    Geolocalizacion publica \n"
          printf "\t$red[ip_t]$green     IP publica a travez de TOR\n"
          printf "\t$red[geo_t]$green    Geolocalizacion publica a travez de TOR\n"
          printf "\t$red[telnet]$green   Tor + Telnet+9999 Backdoor EH gateways 9999-->\n"
          printf "\t$red[nc]$green       Tor + nc-->\n"
          printf "\t$red[nmap]$green     Tor + nmap-->\n"
          printf "\t$red[ssh]$green      Tor + ssh-->\n"
          printf "\t$red[ftp]$green      Tor + ftp-->\n"
          printf "\t$red[nbt]$green      Tor + nmblookup-->\n"
          printf "\t$red[modbus_r]$green Tor + modbus read-->\n"
          printf "\t$red[modbus_w]$green Tor + modbus write-->\n"
          printf "\t$red[mqtt_sub]$green Tor + MQTT SUB-->\n"
          printf "\t$red[tor_web]$green  WebBrowser Tor-->\n"
          printf "\t$red[beter]$green    battercap mitm-->\n"
          printf "\t$red[v]$green        Volver-->\n"
          printf "\t$green==========================================\n"
          printf "\t$red[*]-:"
          printf $normal
          
          read opc
          case $opc in

        ip_p) 
             #****************************************************************************************
             caption='La ip publica es:'
             simbol='[*]-:'
             say $caption $simbol
             #****************************************************************************************
             curl http://ifconfig.me
             pause;;
          
       geo_p)
             #****************************************************************************************
             caption='La geolocalizacion publica es:'
             simbol='[*]-:'
             say $caption $simbol
             #****************************************************************************************
          
             curl ip-api.com
             #http://www.google.com/maps/place/-34.6033,-58.3816/@-34.6033,-58.3816,16z
             pause;;    
    
       ip_t)
             caption='Tu ip publica a traves de tor es:'
             simbol='[*]-:'
             say $caption $simbol
             #****************************************************************************************
             
             proxychains curl -S http://ifconfig.me
             pause;;   
    
       geo_t)
             caption='Geolocalizacion a traves de Tor. '
             simbol='[*]-:'
             say $caption $simbol
             #****************************************************************************************
             
             proxychains curl http://ip-api.com
             #http://www.google.com/maps/place/-34.6033,-58.3816/@-34.6033,-58.3816,16z
             pause;;   
       
       telnet)
             #****************************************************************************************          
             caption='¿Ingrese la IP?'
             simbol='[*]-:'
             say $caption $simbol
             #****************************************************************************************
             read ip
            
             #****************************************************************************************
             caption='Ingrese el puerto: '
             simbol='[*]-:'
             say $caption $simbol
             #****************************************************************************************
             read port
             #****************************************************************************************
            
             proxychains telnet $ip $port
             pause;;
          
         
          nc)
             #****************************************************************************************          
             caption='Ingrese la IP'
             simbol='[*]-:'
             say $caption $simbol
             #****************************************************************************************
             read ip
            
             #****************************************************************************************
             caption='Ingrese el puerto: '
             simbol='[*]-:'
             say $caption $simbol
             #****************************************************************************************
             read port
             #****************************************************************************************
            proxychains nc $ip $port
            pause;;
          
          #Anonymous
          nmap)
             #****************************************************************************************          
             caption='Ingrese la IP'
             simbol='[*]-:'
             say $caption $simbol
             #****************************************************************************************
             read ip
            
             #****************************************************************************************
            
            proxychains nmap $ip 
            pause;;
          
          ssh)
             #****************************************************************************************          
             caption='Ingrese la IP'
             simbol='[*]-:'
             say $caption $simbol
             #****************************************************************************************
             read ip
            
             #****************************************************************************************
             caption='Ingrese el Usuario: '
             simbol='[*]-:'
             say $caption $simbol
             #****************************************************************************************
             read user
             #****************************************************************************************
            proxychains ssh $user@$ip  
            pause;;
          
          ftp)
            
             #****************************************************************************************          
             caption='Ingrese la IP'
             simbol='[*]-:'
             say $caption $simbol
             #****************************************************************************************
             read ip
          
             proxychains ftp $ip  
             pause;;
          
          nbt)
             #****************************************************************************************          
             caption='Ingrese la IP'
             simbol='[*]-:'
             say $caption $simbol
             #****************************************************************************************
             read ip
            
             proxychains nmblookup -S -U $ip -R
             pause;;
             
             
          modbus_r) #400001    1..99999 for coils    400001..499999 ana 300001
             #****************************************************************************************          
             caption='Ingrese la IP'
             simbol='[*]-:'
             say $caption $simbol
             #****************************************************************************************
             read ip
           
             #****************************************************************************************          
             caption='Ingrese los registros 400001'
             simbol='[*]-:'
             say $caption $simbol
             #****************************************************************************************
             read reg
 
             #****************************************************************************************          
             caption='Ingrese la cantidad:'
             simbol='[*]-:'
             say $caption $simbol
             #****************************************************************************************
             read cant
 
             proxychains modbus read --output script/modbus-tcp/$ip.yml $ip $reg $cant
            
             #****************************************************************************************          
             caption='Archivo creado en script/modbus-tcp/'$ip.yml2
             simbol='[*]-:'
             say $caption $simbol
             #****************************************************************************************
             pause;;
          
          mqtt_sub)   #shodan mqtt port:"1883"
             #****************************************************************************************          
             caption='Ingrese la IP'
             simbol='[*]-:'
             say $caption $simbol
             #****************************************************************************************
             read ip
           
             #****************************************************************************************          
             caption='Ingrese el Topic'
             simbol='[*]-:'
             say $caption $simbol
             #****************************************************************************************
             read topic
             
             proxychains mosquitto_sub -h $ip -v -p 1883 -t $topic/#
             pause;;
          
          #arduino/living_room/touch_sensor/set 1
          
          mqtt_pub)   #shodan mqtt port:"1883"
             #****************************************************************************************          
             caption='Ingrese la IP'
             simbol='[*]-:'
             say $caption $simbol
             #****************************************************************************************
             read ip
           
             #****************************************************************************************          
             caption='Ingrese el Topic'
             simbol='[*]-:'
             say $caption $simbol
             #****************************************************************************************
             read topic
             
             #****************************************************************************************          
             caption='Ingrese el Valor del Topic'
             simbol='[*]-:'
             say $caption $simbol
             #****************************************************************************************
             read set1
             
             proxychains mosquitto_pub -h $ip -v -p 1883 -t $topic -m $set1
             pause;;
          
       tor_web)
                #cd /home/pablo/Descargas/tor-browser_es-ES
                tor_web https://ipleak.net/
                #./start*
                pause;;
       beter)
             #****************************************************************************************          
             caption='Ingrese la IP'
             simbol='[*]-:'
             say $caption $simbol
             #****************************************************************************************
             read ip
       
             sudo bettercap -T $ip --proxy -P POST 
             pause;;
             
              
       w-shark)
            wlan="wlxf8d111144e71"
            sudo wireshark -i$wlan -k -s512  
            pause;;
        
       tcpdump)
               wlan="wlxf8d111144e71"
               sudo tcpdump -i $wlan -n -w file.pcap
               read;;  
         
          v)
          return 0;;
        *)
          printf "Seleciona una opcion valida :)";
          pause;;          
  esac
        
done
