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

path=${PWD}"/"
                
                printf "\t$red[g-ini]$normal  GIT INIT\n"
                printf "\t$red[g-rm]$normal   GIT RM\n"
                printf "\t$red[g-up]$normal   GIT PUSH\n"
                
                printf "$green Entrar opcion [*]:$red"
                read opc2
                case $opc2 in
                   g-rm)
                        printf "Ingrese la carpeta a eliminar -->" 
                        read folder 
                        git rm --cached $path$folder -r
                        git commit -m "eliminando...."
                        git push -f origin master
                        read;;
                   g-ini)
                   
                        printf "Ingrese la carpeta a generar git -->" 
                        read folder 
                        echo "# prueba" >> README.md
                        git init
                        git add README.md
                        git commit -m "first commit"
                        git remote add origin git@github.com:pablinn/$folder.git
                        git push -u -f origin master
                        read;;
                  g-up)
                      printf "Ingrese el archivo a comitear-->" 
                      read file
                              
                      git add $path$file
                      echo -n $path$file
                      git commit -m "Agregando archivo"
                      git push -f origin master
                      read;;
               

          v)
          return 0;;
        *)
          printf "Seleciona una opcion valida :)";
          pause;;          
  esac
        
done
