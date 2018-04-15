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
   printf "\t$red[256]$green    Generador de hash sha256-->\n"
          printf "\t$red[512]$green    Generador de hash sha512 -->\n"
          printf "\t$red[md5]$green    Generador de hash md5 -->\n"
          printf "\t$red[b64e]$green   Generador de hash base 64 encode-->\n"
          printf "\t$red[b64d]$green   Generador de hash base 64 decode -->\n"
          printf "\t$red[aese]$green   Generador de hash openssl aes encode-->\n"
          printf "\t$red[aesd]$green   Generador de hash openssl aes decode -->\n"
          printf "\t$red[rsa]$green    ssh-keygen hash para github -->\n"
          
          printf "$green Entrar opcion [*]:$red"
          read opc2
          case $opc2 in
               256) 
           printf "Hash sha256 -->"
           read pass
           printf $pass | sha256sum |awk '{print toupper($0)}'|sed 's/ //g'|sed 's/-//g' 
           printf "Listo pulsar enter :) \n"
           read;;
           
           512) 
           printf "Hash sha512r -->"
           read pass
           printf $pass | sha512sum |awk '{print toupper($0)}'|sed 's/ //g'|sed 's/-//g' 
           printf "Listo pulsar enter :) \n"
           read;;
           md5)
           printf "hash MD5-->"
           read pass
           printf $pass | md5sum |awk '{print toupper($0)}'|sed 's/ //g'|sed 's/-//g' 
           printf "Listo pulsar enter :) \n"
           read;;
           
           b64e)
           printf "BaSe 64 EnCode -->"
           read pass
           printf $pass | base64 |sed 's/ //g'|sed 's/-//g' 
           printf "Listo pulsar enter :) \n"
           read;;
           
           b64d)
           printf "BaSe 64 DeCode -->"
           read pass
           printf $pass | base64 -d |sed 's/ //g'|sed 's/-//g' 
           printf "Listo pulsar enter :) \n"
           read;;
           
           aese)
           
           printf "AES encode -->"
           read pass
           printf $pass | openssl enc -aes-256-cbc -a  
           printf "Listo pulsar enter :) \n"
           read;;
           
           aesd)
           printf "AES decode -->"
           read pass
           echo $pass | openssl enc -aes-256-cbc -a -d
           printf "Listo pulsar enter :) \n"
           read;;
           
           rsa) 
           path=${PWD}"/ssh/"
                printf "ingrese su email-->"
                read email
                printf "ingrese key usado de pashfrase-->"
                read key
                ssh-keygen -N "" -t rsa -C $email -f $path$key
                cat $path$key.pub
                read;;
           
           md5_dig_ex)
             #https://en.wikipedia.org/wiki/Digest_access_authentication 
             #HA1 md5 user:real:password
             #HA1 = MD5( "Mufasa:testrealm@host.com:Circle Of Life )
                   #= 939e7578ed9e3c518a452acee763bce9
             #HA2 MD5 uri
             #HA2 = MD5( "GET:/dir/index.html" )
                   #= 39aff3a2bab6126f332b942af96d3366
              
             #resp md5 HA1:nonce:nc:cnonce:auth:HA2
             #Response = MD5( "939e7578ed9e3c518a452acee763bce9:\ 
                   #dcd98b7102dd2f0e8b11d0f600bfb0c093:\
                   #00000001:0a4f113b:auth:\
                   #39aff3a2bab6126f332b942af96d3366" )
            #= 6629fae49393a05397450978507c4ef1

           
           pass="Mufasa:testrealm@host.com:Circle Of Life"
           uri="GET:/dir/index.html"
           
           nonce="dcd98b7102dd2f0e8b11d0f600bfb0c093"
           nc="00000001"
           cnonce="0a4f113b"
           
           HA1=$(echo -n $pass | md5sum |sed 's/ //g'|sed 's/-//g')
           HA2=$(echo -n $uri | md5sum |sed 's/ //g'|sed 's/-//g')
           
           res=$(echo -n $HA1:$nonce:$nc:$cnonce:auth:$HA2 | md5sum |sed 's/ //g'|sed 's/-//g')
           
           printf $HA1"\n"
           printf $HA2"\n"
           printf $res"\n"
           
           printf "Listo pulsar enter :) \n"
           read;;

          
          md5_dig)
          
             #Authorization: Digest username="spp", realm="1766-L32BWA B/10.00", nonce="a4b8c8d7e0f6a7b2c3d2e4f5a4b7c5d2e7f",
             #uri="/filelist.xml", algorithm=MD5, response="c9ee3787a74d255663ea7b076d4d031e", qop=auth, nc=00000008, cnonce="48a407d0b779196d"
             #Connection: keep-alive
             
             #HA1 md5 user:real:password
             #HA2 MD5 uri
              
             #resp md5 HA1:nonce:nc:cnonce:auth:HA2
           
           user="spp"
           realm="1766-L32BWA B/10.00"
           pass="E4B0DA8A66"       
                 
           dig="$user:$realm:$pass"
           echo $dig
           
           uri="	"
           qop="auth"
           
           nonce="a4b8c8d7e0f6a7b2c3d2e4f5a4b7c5d2e7f"
           nc="00000008"
           cnonce="48a407d0b779196d"
           
           HA1=$(echo -n $dig | md5sum |sed 's/ //g'|sed 's/-//g')
           HA2=$(echo -n $uri | md5sum |sed 's/ //g'|sed 's/-//g')
           
           res=$(echo -n $HA1:$nonce:$nc:$cnonce:$qop:$HA2 | md5sum |sed 's/ //g'|sed 's/-//g')
           
           printf $HA1"\n"
           printf $HA2"\n"
           printf $res"\n"
           
           printf "Listo pulsar enter :) \n"
           read;;
           
          v)
          return 0;;
        *)
          printf "Seleciona una opcion valida :)";
          pause;;          
  esac
        
done

#https://166.130.145.60/ admin admin
