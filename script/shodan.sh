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


    key="qPNveosIR0CojJX53DwJoR4U9KoPjcZm"
    host="https://api.shodan.io"


while true

do
clear

              printf "\t$green==========================================\n"
              printf "\t$red  API-SHOADAN\n"
              printf "\t$red  \n"
              printf "\t$green==========================================\n"
              printf "\t$red[sh_port]$green  Listar puertos\n"
              printf "\t$red[sh_proto]$green Listar protocolos\n"
              printf "\t$red[sh_host]$green  Listar puertos\n"
              printf "\t$red[sh_all]$green   Listar puertos\n"
              printf "\t$red[sh_scan_r]$green  Listar puertos\n"
              printf "\t$red[sh_scan_all]$green  Listar puertos\n"
              printf "\t$red[sh_AB]$green   Busca PLC Allen Bradley\n"
              printf "\t$red[sh_txt]$green  Genera un archivo de txt con el jason parseado\n"
              printf "\t$green============================================\n"
              
              printf "$green Entrar opcion [*]:$red"
              read opc2
              
              case $opc2 in
              
              
                    1)
                    
                       key="qPNveosIR0CojJX53DwJoR4U9KoPjcZm"
                       host="https://api.shodan.io"
                       api="/shodan/ports?key="$key
                      
                      query="https://api.shodan.io/shodan/host/search?key=qPNveosIR0CojJX53DwJoR4U9KoPjcZm&query=hart-ip"
                      curl -s query # | app/json/JSON.sh -b
                      pause;;
                    
                    sh_port)
                            #https://api.shodan.io/shodan/ports?key={YOUR_API_KEY}
              
                            key="qPNveosIR0CojJX53DwJoR4U9KoPjcZm"
                            host="https://api.shodan.io"
                            api="/shodan/ports?key="$key
              
                            echo -e $yellow
                            echo -e $host$api
                            echo -e $green          
                            curl -s $host$api$dato | app/json/JSON.sh -b
                    read;;                 
              
                    sh_proto)
                             #https://api.shodan.io/shodan/protocols?key=
                             key="qPNveosIR0CojJX53DwJoR4U9KoPjcZm"
                             host="https://api.shodan.io"
                             api="/shodan/protocols?key="$key
                             echo -e $yellow
                             echo -e $host$api
                             echo -e $green
                             curl -s $host$api$dato | app/json/JSON.sh -b
                    read;;
                    
                    sh_scan_r)
                           printf "query--:"
                           read query
                           printf "port--:"
                           read port
                           
                           #https://api.shodan.io/shodan/host/search?key={YOUR_API_KEY}&query={query}&facets={facets}
                           key="qPNveosIR0CojJX53DwJoR4U9KoPjcZm"
                           host="https://api.shodan.io"
                           api="/shodan/host/search?key=$key&query=\"$query\"&facets=\"port:"$port"\""
                           #https://api.shodan.io/shodan/host/search?key=qPNveosIR0CojJX53DwJoR4U9KoPjcZm&query=%22hart-ip%22&facets=%22port:5094%22
                           echo -e $yellow
                           echo -e $host$api
                           echo -e $green
                           
                           curl -s $host$api$dato | app/json/JSON.sh -b | grep "data\|port\|ip_str\|latitude\longitude\|transport"  #| grep "http\",\"host"
                           echo -e "listo"
                    read;;

                    
                    sh_scan_all)
                           #https://api.shodan.io/shodan/host/search?key={YOUR_API_KEY}&query={query}&facets={facets}
                           key="qPNveosIR0CojJX53DwJoR4U9KoPjcZm"
                           host="https://api.shodan.io"
                           api="/shodan/host/search?key=$key&query=\"hart-ip\"&facets=\"port:5094\""
                           #https://api.shodan.io/shodan/host/search?key=qPNveosIR0CojJX53DwJoR4U9KoPjcZm&query=%22hart-ip%22&facets=%22port:5094%22
                           echo -e $yellow
                           echo -e $host$api
                           echo -e $green
                           
                           curl -s $host$api$dato | app/json/JSON.sh -b 
                           echo -e "listo"
                    read;;
                    
                    sh_AB)
                    #1766-L32AWAA B/14.00
                    
                           query="Automation/Allen-Bradley" 
                           facet="port:502"
                                                      
                           key="qPNveosIR0CojJX53DwJoR4U9KoPjcZm"
                           host="https://api.shodan.io"
                           api="/shodan/host/search?key=$key&query=\"$query\"&facets=\"$facet\""
                           
                           echo -e $yellow
                           echo -e $host$api
                           echo -e $green
                           
                           #curl -s -L $host$api$dato | app/json/JSON.sh -b | grep "data\|port\|ip_str\|latitude\longitude\|transport\|product"  
                           abb=$(curl -s -L $host$api$dato | app/json/JSON.sh -b | grep "ip_str" | awk '{print ($2)}')
                           
                           for i in $abb
                           do 
                              
                              xdotool exec --sync --args 2 firefox 'http://'${i} |sed 's/"//g'  
                           done
                            
                           #xdotool exec --sync --args 2 firefox
                           echo -e "listo"                                               
                    
                    read;;
                
                    sh_txt)                  
                           #hart HART-IP port:5094  #| grep "data\|port\|ip_str\|latitude\longitude\|transport"  
                           #plc  Automation/Allen-Bradley port:502 #| grep "data\|port\|ip_str\|latitude\longitude\|transport\|product"  
                           
                           
                           #modbus port:502
                           
                           query="Automation/Allen-Bradley" 
                           facet="port:502"
                           
                           #apache+port:80
                           #Rockwell Automation/Allen-Bradley
                           
                           key="qPNveosIR0CojJX53DwJoR4U9KoPjcZm"
                           host="https://api.shodan.io"
                           api="/shodan/host/search?key=$key&query=\"$query\"&facets=\"$facet\""
                           
                           echo -e $yellow
                           echo -e $host$api
                           echo -e $green
                           
                           curl -s -L $host$api$dato | app/json/JSON.sh -b >> sh_header/plc.txt #| grep "data\|port\|ip_str\|latitude\longitude\|transport"  
                           
                           echo -e "listo"                                               
                    read;;  
                    
                    sh_all)
                          #https://api.shodan.io/shodan/host/{ip}?key=
                          #https://api.shodan.io/shodan/host/count?key={YOUR_API_KEY}&query={query}&facets={facets}
                          #https://api.shodan.io/shodan/host/search?key={YOUR_API_KEY}&query={query}&facets={facets}
                          #https://api.shodan.io/shodan/host/search/tokens?key={YOUR_API_KEY}&query={query}
                          #https://api.shodan.io/shodan/ports?key={YOUR_API_KEY}
                          #https://api.shodan.io/shodan/protocols?key=
                          printf "Ingrese el host remoto ip -->" 
                          read ip
                          key="qPNveosIR0CojJX53DwJoR4U9KoPjcZm "
                          host="https://api.shodan.io"
                          api="/shodan/host/{$ip}?key="$key
                          echo -e $yellow
                          echo -e $host$api
                          echo -e $green
                          curl -s $host$api$dato | app/json/JSON.sh -b
                          pause;;


          v)
          return 0;;
        *)
          printf "Seleciona una opcion valida :)";
          pause;;          
  esac
        
done

#https://www.shodan.io/search?query=port%3A5094+hart-ip
