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

chek(){
	if [ -x /usr/bin/$1 ] || [ -x /usr/sbin/$1 ] || [ -x /usr/local/bin/$1 ] || [ -x /bin/$1 ]; then
          echo "El programa \"$1\" está instalado."
          val='1'
           else
          echo "No está instalado \"$1\"."
          val='0'
          
          fi
          
          
   
}




while true

do
clear
        printf "\t$green==========================================\n"
        printf "\t$red[hack]$green     Software requerido\n" 
        printf "\t$green==========================================\n"
        printf "\t$red[hack]$green     Hack tools\n"
        printf "\t$red[opt]$green      Tools en la carpeta /OPT \n"
        printf "\t$red[snif]$green     aircrack-ng cowpatty pyrit  \n" 
        printf "\t$red[net]$green      Net tools \n"
        printf "\t$red[compiler]$green Compiler Tools\n"
        printf "\t$red[tts]$green      TTS speech to text\n"
        printf "\t$red[ecoin]$green    Soft para minar eCoins\n"
        printf "\t$green==========================================\n"
        printf "\t$red[*]-:"
        printf $normal
        
        read opc2
        case $opc2 in
          
     opt)
          #tor web browser
          chek tor_web
          if [ $val == '0' ] 
          then
          wget https://www.torproject.org/dist/torbrowser/7.5.3/tor-browser-linux64-7.5.3_es-ES.tar.xz
          tar xf  tor-browser-linux64-7.5.3_es-ES.tar.xz
          rm tor-browser-linux64-7.5.3_es-ES.tar.xz
          sudo mv tor-browser* /opt/
          sudo ln -sf /opt/tor-browser_es-ES/browser/start-tor-browser /usr/local/bin/tor_web
          fi
          
          
          #osint operative
          chek operative
          if [ $val == '0' ] 
          then
          echo "No está instalado \"$1\"."
          sudo git clone https://github.com/graniet/operative-framework.git /opt/operative-framework
          cd /opt/operative-framework
          pip install -r requirements.txt
          sudo chmod +x /opt/operative-framework/coperative.py
          sudo ln -s /opt/operative-framework/operative.py /usr/local/bin/operative
          fi
          
          #chek  wifite 1 comentado wifite2
          if [ $val == '0' ]
          then
          echo "No está instalado \"$1\"."
          #git clone https://github.com/derv82/wifite.git soft/wifite
          #cd soft/wifite
          #chmod +x wifite.py
          #sudo mv wifite.py /usr/local/bin/wifite.py
                    
          sudo git clone https://github.com/derv82/wifite2 /opt/wifite2
          sudo chmod +x /opt/wifite2/Wifite.py
          sudo ln -sf /opt/wifite2/Wifite.py /usr/local/bin/wifite
          fi 
          
          chek searchsploit
          if [ $val == '0' ]
          then
          echo "No está instalado \"$1\"."
          xdotool exec --sync --args 2  firefox https://www.exploit-db.com/
          sudo git clone https://github.com/offensive-security/exploit-database.git /opt/exploit-database
          sudo ln -sf /opt/exploit-database/searchsploit /usr/local/bin/searchsploit
          sudo ln -sf /opt/exploit-database/searchsploit /usr/bin/searchsploit
          sudo ln -sf /opt/exploit-database/searchsploit /usr/sbin/searchsploit
          fi
          
          #cowpatty 
          chek cowpatty
          if [ $val == '0' ]
          then
          echo "No está instalado \"$1\"."
          sudo apt-get install libpcap-dev libssl-dev build-essential libpcap0.8-dev libdigest-hmac-perl
          wget http://www.willhackforsushi.com/code/cowpatty/4.6/cowpatty-4.6.tgz
          tar zxvf  cowpatty-4.6.tgz
          cd cowpatty-4.6
          make
          sudo make install
          sudo rm cowpatty*
          fi
          
          chek wifi_honey 
          if [ $val == '0' ]
          then
          echo "No está instalado \"$1\"."
          wget https://digi.ninja/files/wifi_honey_1.0.tar.bz2
          sudo apt-get install screen
          tar xvfj wifi_honey_1.0.tar.bz2
          sudo rm wifi_honey_1.0.tar.bz2
          sudo mv wifi_honey /opt/
          sudo chmod +x /opt/wifi_honey/wifi_honey.sh
          sudo ln -sf /opt//wifi_honey/wifi_honey.sh /usr/local/bin/wifi_honey
          fi
           
          chek reaver 
          if [ $val == '0' ]
          then
          echo "No está instalado \"$1\"."
          sudo apt-get -y install build-essential libpcap-dev aircrack-ng
          sudo git clone https://github.com/t6x/reaver-wps-fork-t6x.git soft/reaver-wps-fork-t6x
          cd reaver-wps-fork-t6x*
          cd src
          ./configure
          make
          sudo make install
          fi
             
          pause;;              
          
     
       
      snif)  #bettercap tshark wireshark
          
          chek bettercap
          if [ $val == '0' ]
          then
          echo "No está instalado \"$1\"."
          sudo apt install build-essential ruby-dev libpcap-dev net-tools
          sudo apt install ruby
          sudo gem install bettercap
          gem update bettercap
          
          fi
                
          
          chek tshark
          if [ $val == '0' ]
          then
          echo "No está instalado \"$1\"."
          sudo apt-get install tshark
          fi
          
          #chek bully
          #if [ $val == '0' ]
          #then
          #echo "No está instalado \"$1\"."
          #sudo apt-get install bully
          #fi
          
          chek macchanger
          if [ $val == '0' ]
          then
          echo "No está instalado \"$1\"."
          sudo apt-get install macchanger
          fi         
          
          
           
           pause;;
       
       hack)
       
          
          
          
          
          
          
          
          chek adb
          if [ $val == '0' ]
          then
          echo "No está instalado \"$1\"."
          sudo apt-get install android-tools-adb
          sudo apt-get install android-tools-fastboot
          #Bus 003 Device 021: ID 18d1:d001 Google Inc. 

          fi
          
          
          chek scapy
          
          #chek shodan
          if [ $val == '0' ]
          then
          echo "No está instalado \"$1\"."
          sudo apt-get install pip
          pip install shodan
          fi
                 
          
          
          
          
          chek genpmk
          if [ $val == '0' ]
          then
          echo "No está instalado \"$1\"."
          fi
          
          chek aircrack-ng
          if [ $val == '0' ]
          then
          echo "No está instalado \"$1\"."
          fi
          
          chek crunch
          if [ $val == '0' ]
          then
          echo "No está instalado \"$1\"."
          fi
          
          chek pyrit
          if [ $val == '0' ]
          then
          echo "No está instalado \"$1\"."
          fi
          
          chek mosquitto
          if [ $val == '0' ]
          then
          echo "No está instalado \"$1\"."
          sudo apt-add-repository ppa:mosquitto-dev/mosquitto-ppa
          sudo apt-get update
          sudo apt-get install mosquitto
          sudo apt-get install mosquitto-clients
          sudo /etc/init.d/mosquitto start
          fi
          
          chek proxychains
          if [ $val == '0' ]
          then
          echo "No está instalado \"$1\"."
          fi
          
          chek tor
          if [ $val == '0' ]
          then
          echo "No está instalado \"$1\"."
          fi
                             
          echo  xploit
          
          
          pause;;
          
          

          
       net)
          chek scp
          chek nc
          chek telnet
          chek tar
          chek wget
          chek ssh
          chek ftp
          chek xdotool
          chek wmctrl
          
          
          
          chek modbus
          if [ $val == '0' ]
          then
          echo "No está instalado \"$1\"."
          sudo apt-get install ruby
          sudo gem install modbus-cli
          fi
          
          chek nmblookup
          if [ $val == '0' ]
          then
          echo "No está instalado \"$1\"."
          sudo apt-get install samba-common-bin
          fi
                   
          chek curl
          if [ $val == '0' ]
          then
          echo "No está instalado \"$1\"."
          fi
          
          chek git
          if [ $val == '0' ]
          then
          echo "No está instalado \"$1\"."
          fi
                    
          chek nmap
          if [ $val == '0' ]
          then
          echo "No está instalado \"$1\"."
          fi
          
          pause;;
          
          #wig gathering wifi
          #sudo apt-get install python-pcapy
          #sudo apt-get install python-impacket
          #https://github.com/6e726d/WIG.git
          #$ sudo iwconfig wlx001a8f30cb1b mode monitor
          #$ sudo ifconfig wlx001a8f30cb1b up
          #$ cd wig
          #$ sudo python <ccx_scanner.py|wps_scanner.py|p2p_scanner.py|hp_scanner.py> <iface>
        
    compiler)   
                   
          
          #compilar - shellcode
          chek gdb
          chek objdump
          chek strace
           
          chek gcc
          if [ $val == '0' ]
          then
          echo "No está instalado \"$1\"."
          fi
          
          chek as
          if [ $val == '0' ]
          then
          echo "No está instalado \"$1\"."
          fi
              
          
          chek arm-linux-gnueabihf-gcc
          if [ $val == '0' ]
          then
          echo "No está instalado \"$1\"."
          sudo apt-get install gcc-arm-linux-gnueabihf
          fi
                             
          chek arm-linux-gnueabi-gcc
          if [ $val == '0' ]
          then
          echo "No está instalado \"$1\"."
          sudo apt-get install gcc-arm-linux-gnueabi
          fi
          
          pause;;  

          
       tts) # tts stt
          echo beta test
          chek festival
          if [ $val == '0' ]
          then
          echo "No está instalado \"$1\"."
          apt-get install festival festvox-ellpc11k
          #corregir bug en voice spanish ver pdf
          wget https://raw.githubusercontent.com/guadalinex-archive/hispavoces/master/packages/festvox-palpc16k_1.0-1_all.deb
          sudo dpkg -i festvox-palpc16k_1.0-1_all.deb
          #comprobacion de vos tts       
          hora=`date`
          hora=`echo $hora |cut -f4 -d " "`
          h=`echo $hora |cut -f1 -d ":"`
          m=`echo $hora |cut -f2 -d ":"`
          s=`echo $hora |cut -f3 -d ":"`
          echo "Son las $h horas. $m minutos. con $s segundos."  | iconv -f utf-8 -t iso-8859-1|festival --tts
          fi
          
          chek pocketsphinx_continuous
          if [ $val == '0' ]
          then
          echo "No está instalado \"$1\"."
          git clone https://github.com/cmusphinx/pocketsphinx.git
          cd pocketsphinx
          ./autogen.sh
          ./configure
          make clean all
          make check
          sudo make install
          fi
          #beta test
          #path="/home/pablo/Descargas/pocket"
          #pocketsphinx_continuous -mdef $path/H4.2500.mdef -lm $path/H4.arpa.Z.DMP -hmm $path/H4.cd_continuous_8gau -dict $path/h4.dict -feat s3_1x39 -infile $path/foo.wav
          pause;;
          
     ecoin)
          echo software para minar
          chek cpuminer
          if [ $val == '0' ]
          then
          echo "No está instalado \"$1\"."
          sudo apt-get install automake autoconf pkg-config libcurl4-openssl-dev libjansson-dev libssl-dev libgmp-dev make g++
          git clone https://github.com/tpruvot/cpuminer-multi soft/cpuminer-multi
          cd cpuminer-multi
          ./autogen.sh
          ./configure CFLAGS="-march=native" --with-crypto --with-curl
          ./build.sh
          sudo make install
          fi
          
          
          
          
          pause;;
          
          v)
          return 0;;
        *)
          printf "Seleciona una opcion valida :)";
          pause;;          
  esac
        
done
