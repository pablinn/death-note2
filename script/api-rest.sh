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

printf "\t$cyan CURL y Bash Socket experimental\n"
          #***shodan
          printf "\t$red[shodan]$green   API-Shodan \n"
          printf "\t$red[sh_port]$green  API-Shodan Lista de puertos\n"
          printf "\t$red[sh_proto]$green API-Shodan Lista de protocolos\n"
          printf "\t$red[sh_host]$green API-Shodan Lista de protocolos\n"
          
          #**shellstorm
          printf "\t$red[storm]$green    API-Shellstorm Busqueda de shellcode\n"
          #**openwheatermap
          printf "\t$red[owm]$green      API-OpenWeatherMap clima - curl\n"
          printf "\t$red[owms]$green     API-OpenWeatherMap clima socket bash\n"
          #**googlegeo
          printf "\t$red[geo]$green      API-google Geolocalizacion\n"
          printf "\t$red[news]$green      API-google Geolocalizacion\n"
          
          printf "\t$red[sock]$green     Bash Socket para pruebas\n"
          printf "\t$red[modbus]$green   Modbus-Tcp experimental\n"
          printf "$green Entrar opcion [*]:$red"
          read opc2
          case $opc2 in
          
          #curl -s 'https://api.github.com/users/pablin' | app/json/JSON.sh -b | grep "login"
          pru)
               curl -s 'https://api.github.com/users/pablin' | app/json/JSON.sh -b | grep "login"
               read;;
          news)
                #https://hacker-news.firebaseio.com/v0/item/8863.json?print=pretty
              
                api2=" https://hacker-news.firebaseio.com/v0/item/15629308.json?print=pretty"
                api3=" https://hacker-news.firebaseio.com/v0/user/github.json?print=pretty"
                
               api="https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty"
               id=$(curl -s $api | app/json/JSON.sh -b | awk -F"[\t]" {'print $2'})
               
               
               echo $green
               for i in $id
               do
                   curl -s -L "https://hacker-news.firebaseio.com/v0/item/"$i".json?print=pretty" | app/json/JSON.sh -b | grep 'by\|url\|title'
                   #printf  "*******************************************\n"
               done
               
               
               #curl -s $api2 | app/json/JSON.sh -b | grep 'by\|url\|title'  
               #grep '^\["tt*,^\["uu*' que comienzen con y que contengan todos lo patrones
          
          
          read;;
                 
          storm)
              # http://shell-storm.org/api/?s=<keyword>  o  /?s=<keyword1>*<keyword2>*<keyword3>
              host="http://shell-storm.org"
              api="/api/?s="
              
              printf "Ingrese shellcode s buscar arm intel win lin keyword con * ej arm*windows --> " 
              
              read dato
              echo -e $yellow
              echo -e $host$api$dato
              echo -e $blue
              curl -s $host$api$dato | sed "s/::::/\t/g" | awk -F"[\t]" {'print "auror--> " $1 " Tipo--> " $2 " url-->" $5'} 
           read;;
              
              #prototipo funciona muy bien mejor que curl inconvenientes filtrar con grep o json
              #head="GET /api/?s="$dato" HTTP/1.0\r\n"
              #dato1="Host: shell-storm.org\r\n"
              #dato2="Content-Type: application/json\r\n"
              #dato3="Connection: close\r\n\r\n"
              #echo -e $head$dato1$dato2$dato3                                                    
              #exec 3<>/dev/tcp/shell-storm.org/80
              #echo -e $head$dato1$dato3 >&3
              #cat <&3
              #exec 3>&-
              #read;;
              
          owm)
              #API openweathermap clima
              key="4074c704aa16735532f97a8b18a0020e"
              lat="-37.8814"
              lon="-67.8277"
              host="http://api.openweathermap.org"
              api="/data/2.5/weather?lat="$lat"&lon="$lon"&APPID="$key"&units=metric&lang=es"
              
              #curl -s -L "http://api.openweathermap.org/data/2.5/weather?lat="$lat"&lon="$lon"&APPID="$key"&units=metric&lang=es"| app/json/JSON.sh -b
              echo -e $yellow
              echo -e $host$api
              echo -e $green
              curl -s $host$api | app/json/JSON.sh -b
              read;;
              
          owms)
              #api openweathermap usando bash socket
              key="4074c704aa16735532f97a8b18a0020e"
              lat="-37.8814"
              lon="-67.8277"
              
              head="GET /data/2.5/weather?lat="$lat"&lon="$lon"&APPID="$key"&units=metric&lang=es HTTP/1.0\r\n"
              dato1="Host:api.openweathermap.org\r\n"
              dato2="Content-Type:application/json\r\n"
              dato3="Connection:close\r\n\r\n"
              echo -e $yellow$head$dato1$dato2$dato3                          
              
              exec 3<>/dev/tcp/api.openweathermap.org/80
              echo -e $head$dato1$dato2$dato3 >&3
              retu=`dd bs=2048 count=1 <&3 2> /dev/null`
              echo -e $green
              echo -e -n "$retu" | sed -n -e '/{/,/$}/p'| app/json/JSON.sh -b
              #cat <&3 
              exec 3>&-                                                      
              read;;
                           
              
          geo)
              #api-key  
              key="AIzaSyAe4Z2ng-doKeagGz7tpr3DWjWAL5qXR08"
              
              head="POST /geolocation/v1/geolocate?key="$key" HTTP/1.1\r\n"
              datos1="Host:www.googleapis.com\r\n"
              datos2="Content-Type:application/json\r\n"
              payload="{\"macAddress\": \"D0:FC:CC:A5:7B:F9 \", \"signalStrength\": -43,\"age\": 0,\"channel\": 11,\"signalToNoiseRatio\": 0}\n"
              datos3="Content-Length:"${#payload}"\r\n\r\n"
              datos4="Connection:close\r\n"
       
              echo -e $yellow$head$datos1$datos2$datos4$datos3$payload
              echo -e $green
              
              # sed -n -e '/{/,/$}/p'  corta desde { hasta el final}              
              echo -e $head$datos1$datos2$datos4$datos3$payload | openssl s_client -connect www.googleapis.com:443 -ign_eof 2>/dev/null | sed -n -e '/{/,/$}/p' | app/json/JSON.sh -b
              read;;
         
         osint)  
         
               # https://encrypted.google.com/search?num=5&start=0&hl=en&q=site:linkedin.com/in+tgn.com.ar
               echo -e "GET /search?num=5&start=0&hl=en&q=site:linkedin.com/in+tgn.com.ar HTTP/1.1\r\n" | openssl s_client -connect encrypted.google.com:443 -ign_eof 2>/dev/null |  grep "item_description" | sed 's/<div class=\"item_description\" itemprop=\"description\">/\ /' | sed 's/<\/div>/\n/'
         
               pause;;
         
         AB)
              host="61.57.52.66"
               
              head="GET /dataview.htm HTTP/1.1\r\n"
              datos1="Host: $host\r\n"
              
              datos4="Connection: keep-alive\r\n"
       
              echo -e $yellow$head$datos1
              echo -e $green

              exec 3<>/dev/tcp/$host/80
              echo -e $head$dato1 >&3
              #retu=`dd bs=5000 count=2 <&3 2> /dev/null`
              echo -e $green
              #echo -e -n "$retu" #| sed -n -e '/{/,/$}/p'| app/json/JSON.sh -b
              cat <&3 
              exec 3>&-                                                      

         read;;
         
         eh)
         a='POST /Forms/reboot_1 HTTP/1.1\r\n'
         b='Host: 166.130.106.243:81\r\n'
#User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:59.0) Gecko/20100101 Firefox/59.0
#Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8
#Accept-Language: en-US,en;q=0.5
#Accept-Encoding: gzip, deflate
         c='Referer: http://166.130.106.243:81/admin/reboot.htm\r\n'
         d='Content-Type: application/x-www-form-urlencoded\r\n'
         e='Content-Length: 13\r\n'
         f='Connection: keep-alive\r\n'
         g='Upgrade-Insecure-Requests: 1\r\n\r\n'
         
         h='Submit=Reboot'
         
              exec 3<>/dev/tcp/166.130.106.243/81
              echo -e $head$a$b$c$d$e$f$g$h >&3
              #retu=`dd bs=5000 count=2 <&3 2> /dev/null`
              echo -e $green
              #echo -e -n "$retu" #| sed -n -e '/{/,/$}/p'| app/json/JSON.sh -b
              cat <&3 
              exec 3>&-            
         
         pause;;
         sock)
              printf "Ingrese el host remoto rhost -->" 
              read rhost
              printf "Ingrse el remote port rport -->" 
              read rport
                           
              head="GET / HTTP/1.0\r\n"
              dato1="Host:"$rhost"\r\n"
              dato2="Connection:close\r\n\r\n"
              
              echo -e $yellow$head$dato1$dato2
              echo -e $green
              
              exec 3<>/dev/tcp/$rhost/$rport
              echo -e $head$dato1$dato2 >&3
              cat <&3
              exec 3>&-
              read;;   
              
           modbus)
                 # printf "Ingrese el host remoto rhost -->" 
                 #read rhost
                 rhost=217.128.188.179
                 rport=502
                 echo -e $rhost:$rport
                 payload="\x00\x00\x00\x00\x00\x06\x01\x03\x00\x00\x00\x05"
                 
                 payload2="0x000000000006010300000005"
                 #echo $((payload2))
                 #printf "%d\n" $payload2   #decimal
                 printf "%#010x\n" 8
                 printf "0x%08x\n" 8         
                 printf "%#08x\n" 8
                                              
                exec 3<>/dev/tcp/$rhost/$rport
                echo -e $payload >&3
                #cat <&3
                read -r msg_in <&3
                #echo -n $msg_in  # >&3
                #printf "%u\n" $msg_in
                echo 0x$(printf "%s" "$msg_in" |od -t x8 -An ) #| tr -dc '[:alnum:]')
                #printf a
                exec 3>&-
                pause;;

          v)
          return 0;;
        *)
          printf "Seleciona una opcion valida :)";
          pause;;          
  esac
        
done
