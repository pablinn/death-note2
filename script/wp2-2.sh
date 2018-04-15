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
                printf "\t$red[infw]$green   Informacion de redes wifi\n"
                printf "\t$red[mon_man]$green Pasar de modo monitor a modo managed\n"
                printf "\t$red[man_mon]$green Pasar de modo managed a monitor\n"
           
         #iwconfig
                
         # iw dev
         # sudo iw dev  MON del
         
         # pasar de modo monitor a managed
         #iw phy $phy interface add $wlan type managed
         
         #pasar de modo managed a monitor
         #wlan 
         
         #sudo iw phy phy0 interface add mon0 type monitor
         #sudo iw dev wlan del
         #ifconfig mon0 up
         #iw dev mon0 set freq 2437     
         
         #sudo wireshark -imon0 -k   -f    
         #wireshark -i2 -k -f “host 192.168.1.5” -s512 -w captura_ejemplo.pcap -afilesize:10
         
          printf "$green Entrar opcion [*]:$red"
          read opc2
          case $opc2 in
          
           mon_man)
                   printf "Ingrese la interfaz PHY(phy0)-->"
                   read phy
                   printf "Ingrese la interfaz monitor (mon0)-->"
                   read mon
                   printf "Ingrese la interfaz managed(wlan0)-->"
                   read man
                                                   
                  iw dev $mon del
                  iw phy $phy interface add $man type managed
                  iw dev
                  iwconfig $man
                  read;;
                  
          man_mon)
                   canal1=2412
                   canal2=2417
                   canal3=2422
                   canal4=2427
                   canal5=2432
                   canal6=2437
                   canal7=2442
                   canal8=2447
                   canal9=2452
                   canal10=2457
                   canal11=2462
                   canal12=2467
                   canal13=2472
               
                   printf "Ingrese la interfaz PHY(phy0)"
                   read phy
                   printf "Ingrese la interfaz monitor (mon0)"
                   read mon
                   printf "Ingrese la interfaz managed(wlan0)"
                   read man
                   printf "Ingrese nombre del archivo PCAP"
                   read dump
                   
                  iw phy $phy interface add $mon type monitor
                  iw dev $man del
                  ifconfig $mon up
                  iw dev $mon set freq 2437         
                  iwconfig $mon
                  
                  #wireshark
                  #tshark
                  #tcpdump -i $mon -n -w $dump.pcap
                  read;;
                
          infw)
                #Interface iface
                wlan_x=$(iw dev |grep Interface  | awk -F"[\t]" {'print $2'}|sed -u -e 's/Interface //')
                #interfaz phy
                phy_x=$(iw dev |grep phy  | awk -F"[\t]" {'print $1'}|sed 's/#//')
                               
                
                echo -e "Interfaces wlan disponibles: "$blue $wlan_x $normal "\n"
                echo -e "Interfaces phy disponibles:  "$blue $phy_x $normal "\n"
                
                
                               
                #echo -e "Ingrese la interfaz phy y el nombre ej wlan0mon"--->"
                #read phy
                #read wlan 
                                
                #iw phy $phy interface add $wlan type monitor
                                
                read;; 
                
            wpa2c)
     
                  min=8
                  max=10
                  charset=${PWD}"/charset/charset.lst"
                  patron=mixalpha-numeric-symbol14
                  patron_min=lalpha
                  patron_num=numeric
                  aircrack=aircrack-ng
                  #crunch $min $max $charset $ataque
                  path=${PWD}"/hs/"
                  printf "Ingrse el BSID -->"
                  read bsid;
                  printf "Ingrse el handshake pcap -->"
                  read pcap;
     
                  #crunch 8 10 123456789 | aircrack-ng -b D4:6E:0E:54:F8:E6 -w- E-54-F8-E6.cap
                  crunch $min $max -f $charset $patron_min -d 2@ | aircrack-ng -b $bsid -w- $path$pcap.cap
                  read;;      
           wifi)
              printf "Ingrese la interface iface -->" 
              read iface
              
               
               canal1=2412
               canal2=2417
               canal3=2422
               canal4=2427
               canal5=2432
               canal6=2437
               canal7=2442
               canal8=2447
               canal9=2452
               canal10=2457
               canal11=2462
               canal12=2467
               canal13=2472
               
                
               iw dev
               iw phy phy0 info
               iw phy phy0 interface add wlan0mon type monitor
               iw dev wlan0 del
               
               ifwconfig wlan0mon up
               
               iw dev mon0 set freq 2437         
               ifconfig mon0
               tcpdump -i mon0 -n -w file.pcap
               
               
               iw dev mon0 del
               iw phy phy0 interface add wlan0 managed
               iw dev
               iwconfig wlan0
               
               rfkill list
               rfkill unblock 0
               read;;
               
            air)
                 airmon-ng start wlan0
                 airodump-ng mon0
                 airplay-ng -0 5 -a mac_ap -c mac_cli wlan0
                 airdecap-ng
                 airolib-ng
                 airotun-ng
                 airbase-ng
                 read;;   
               
           
          v)
          return 0;;
        *)
          printf "Seleciona una opcion valida :)";
          pause;;          
  esac
        
done
