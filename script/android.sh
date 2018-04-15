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
path=${PWD}"/apk/"
        path2=${PWD}"/app/dex2jar-2.0/"
        
        
        printf "\t$green==========================================\n"
        printf "\t$red[1]$green Decompilar APK con DEX2JAR\n" 
        printf "\t$red[2]$green Compilar APK con DEX2JAR\n"
        printf "\t$red[3]$green Decompilar APK con APKTOOL\n"
        printf "\t$red[4]$green Compilar APK con APKTOOL\n"
        printf "\t$green==========================================\n"
            
        printf "$green Entrar opcion [*]:$red"
        read opc2
        case $opc2 in
        
         
         1)
           printf "\n jar2dex APK-->" ;
           read  nom_f
           unzip -o -d $path$nom_f $path$nom_f.apk
                     
           $path2"d2j-dex2jar.sh" -f $path$nom_f/classes.dex -o $path$nom_f.jar
           read ;;
    
         2)
           printf "\nIngrese el nombre y la ruta del archivo APK-->"
           read nom_f        
		   $path2"d2j-jar2dex.sh" -o $path$nom_f/classes.dex $path$nom_f/$nom_f.jar 
           
           #./$dexd2j-dex-recompute-checksum.sh -f -o $nom_f-n2.apk $nom_f-n.dex
           #zipalign -v 4 $path$nom_f.apk $path$nom_f-n.apk 
           read;;
         3)
           printf "\nIngrese el nombre y la ruta del archivo APK-->"
           read nom_f
           apktool -f d -o $path$nom_f $path$nom_f.apk
           printf "Listo\n pulsar enter :)"
          read ;;
         4) 
          printf "\nIngrese el nombre y la ruta del archivo APK-->"
          read nom_f
          apktool b $path$nom_f
          zipalign -v 4 $path$nom_f.apk $path$nom_f-n.apk 
          printf "Listo\n pulsar enter :)"
          read;;

          v)
          return 0;;
        *)
          printf "Seleciona una opcion valida :)";
          pause;;          
  esac
        
done
