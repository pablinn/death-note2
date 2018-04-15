#[DEATH NOTE]
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

user1=$(whoami)




while :
do
if [ "$user1" == "root" ]; then
  echo " no root"
  # sudo -u raamee my_script
fi
    
    clear
    printf "\t$green==========================================\n"
    printf "\t$red  Menu principal $0\n"
    printf "\t$red  by error-system Catriel Rn Argentina..\n"
    printf "\t$red  Pablo Peñalve \n"
    printf "\t$green==========================================\n"
    printf "\t$red[net]$green    Network Tools (TOR)      \n"    
    printf "\t$red[wpa2]$green   Network Wifi WPA Attack   \n"    
    printf "\t$red[shell]$green  Generador de shellcodes arm | intel\n" 
    printf "\t$red[req]$green    Chequeo de programas y dependencias del script \n"
    printf "\t$red[shodan]$green API-Shodan Tools \n"
    printf "\t$red[req]$green    Chequeo de programas usados por el script  \n"
    printf "\t$red[enc]$green    Encriptacion (sha-256 md5 base64) \n"
    printf "\t$red[api]$green    Implementacion de API REST (openssl-socket-curl-wget) \n"
    printf "\t$red[wpa]$green    Ataques a redes wifi (iw-aircrack-tcdump)\n"
    printf "\t$red[apk]$green    Android APK Tools\n"
    printf "\t$red[git]$green    Github Tools\n"
    printf "\t$red[shut]$green   Apagado automatico de PC \n"
    printf "\t$red[salir]$green  Exit/Stop\n"
    printf "\t$green==========================================\n"
    printf "\t$red[*]-:"
    printf $normal
    
    read opc
    case $opc in
 
 
    #herramientas para malware de apk android
     apk)
        source script/android.sh
        pause;;
        
       # datos de red IP tor
     net) 
          source script/network.sh
          pause;;

     #generacion de shellcode C ASM 
     shell)
           source script/shellcode.sh
           pause;;
 
     #encriptacion sha-256 md5 base-64
     enc) 
          source script/crypto.sh
          pause;;
          
     wpa2)
           source script/wifi-wpa.sh
           pause;;    
      
      #Menu API-SHODAN****************************************************************************************************************************          
       shodan)
              source script/shodan.sh
              pause;;                                           
                    
                   
          
#bash socket experimental inestable**********************************************************************************                    
#dig ss whois nbtstat socat tor-resolve nmap smbclient -L ip  printf "%x\n" $ echo $((16#FF))    
#echo -e -n "$retu" #| sed -n -e '/{/,/$}/p'| app/json/JSON.sh -b
       api) 
          source script/api-rest.sh
          pause;; 
             
#ataques wep/wpa/wpa2*****************************************************************************************************************************     
       wpa)
                
              source script/wp2-2.sh
              pause;;
            
#*******************************************************************************************************************************            
        git)
                source script/github.sh
                pause;;
    
       req)
                source script/requer.sh
                pause;;
                
#***************************************************************************************************    
    shut)
        printf "Apagado automatico Ingrese la cantidad de minutos -->" 
        read min
        shutdown -h +$min
        read;;
              
    salir) exit 0 ;;
    
    *) printf "ohhhh!!! Selecciona unba opcion del menu :)";
       printf "Presiona una tecla...";
       read;;
    
    esac
done
