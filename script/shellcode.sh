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
          printf "\t$green==========================================\n"
          printf "\t$red                Shellcodes\n"
          printf "\t$green==========================================\n"
          printf "\t$red[syscall]$green Syscall segun CPU\n"
          printf "\t$red[aslr]$green    Randomize va space \n"
          printf "\t$red[gcc]$green     Compilador GCC o cross-compiler  \n"
          printf "\t$red[as]$green      Compilador ASM o cross-compiler  \n"
          printf "\t$red[shell]$green   Generar Shellcode \n"
          printf "\t$red[cpuinfo]$green Obtener info del CPU \n"
          printf "\t$red[dbg]$green     Debug GDB \n"
          printf "\t$red[trace]$green   Trasea conStrace \n"
          printf "\t$red[obj]$green     Objdump \n"
          printf "\t$red[search]$green  Buscar exploit en www.xploit-db.com \n"
          printf "\t$red[v]$green       Volver \n"
          printf "\t$green==========================================\n"
          printf "\t$red [*]-:"
          printf $normal
          
          read opc2
          case $opc2 in

 
     aslr)
          
          printf "\nProteccion randomize_va_space A:activar D:desactivar _>"
          read val
          
          if [ $val == "D" ] || [ $val == "d" ]
          then
          printf "Desactivar ASLR.."
          echo 0 | sudo tee /proc/sys/kernel/randomize_va_space
          #printf "Listo pulsar enter :) \n"
          fi
          
          if [ $val == "A" ] || [ $val == "a" ]
          then
          printf "Activar ASLR.."
          echo 2 | sudo tee /proc/sys/kernel/randomize_va_space
          #printf "Listo pulsar enter :) \n"
          fi
          pause;;
   
     syscall)
          #syscall segun el cpu x86_32 | x86_64 | arm
          cpu=$(gcc -dumpmachine)
          
          printf "\nIngrese el nombre de la funcion ej exit/write _>"
          read nom_f
          
          if [ $cpu == "x86_64-linux-gnu" ] 
          then
          printf "Syscall $cpu _>\n"
          cat /usr/include/x86_64-linux-gnu/asm/unistd_64.h | grep $nom_f
          fi
          
          if [ $cpu == "x86_32-linux-gnu" ]
          then
          printf "Syscall $cpu _>\n"
          cat /usr/include/x86_64-linux-gnu/asm/unistd_32.h | grep $nom_f
          fi
          
          if [ $cpu == "arm-linux-gnueabihf" ]
          then
          printf "Syscall $cpu _>\n"
          cat /usr/include/arm-linux-gnueabihf/asm/unistd.h | grep $nom_f
          fi
          
          if [ $cpu == "arm-linux-gnueabi" ]
          then
          printf "Syscall $cpu _>\n"
          cat /usr/include/arm-linux-gnueabi/asm/unistd.h | grep $nom_f
          fi
          
          pause;;
          
      gcc)
          cpu=$(gcc -dumpmachine)
          
          printf "Ingrese el archivo en C a compilar: \n" #| iconv -f utf-8 -t iso-8859-1|festival --tts
          path=${PWD}"/code/"
          read nom_f
          printf "\nCross compiler: y/n: "
          read val
          
          if [ $cpu == "x86_64-linux-gnu" ] || [ $val == "y" ]
          then
          gcc -fno-stack-protector -o $path$nom_f'_x86' $path$nom_f.c
          $path$nom_f'_x86'
          printf "compilaando para $cpu file:"$path$nom_f"_x86\n"
          fi
          
          if [ $cpu == "arm-linux-gnueabi" ] || [ $val == "y" ] 
          then
          arm-linux-gnueabihf-gcc -o $path$nom_f'_arm' $path$nom_f.c
          $path$nom_f'_arm'
          printf "compilaando para $cpu file:"$path$nom_f"_arm\n"
          fi
          
          pause;;
          
     as)
          cpu=$(gcc -dumpmachine)
          
          printf "\nArchivo en ASM: "
          path=${PWD}"/code/"
          read nom_f
          printf "\nCross compiler: y/n: "
          read val
          
          if [ $cpu == "x86_64-linux-gnu" ] || [ $val == "y" ]
          then
          as -o $path$nom_f.o $path$nom_f.s 
          gcc -fno-stack-protector -o $path$nom_f'_x86' $path$nom_f.o
          $path$nom_f'_x86'
          printf "compilaando para $cpu file:"$path$nom_f"_x86\n"
          fi
          
          if [ $cpu == "arm-linux-gnueabi" ] || [ $val == "y" ] 
          then
          
          arm-linux-gnueabihf-as  -o $path$nom_f.o $path$nom_f.s
          arm-linux-gnueabihf-gcc -o $path$nom_f'_arm' $path$nom_f.o
          $path$nom_f'_arm'
          printf "compilaando para $cpu file:"$path$nom_f"_arm\n"
          fi
                    
          pause;;
     
      dbg)    
          #printf "\nIngrese el archivo en C _>"
          #path=${PWD}"/code/"
          #read nom_f
          
		  gdb $path./$nom_f
          #disass main
           
          pause;;
          
      tra)
          #printf "\nIngrese el archivo en C _>"
          #path=${PWD}"/code/"
          #read nom_f
          
		  strace $path./$nom_f
      
          pause;;
          
     obj)
          #printf "\nIngrese el archivo en C _>"
          #path=${PWD}"/code/"
          #read nom_f
           
          objdump -d $path./$nom_f     
          pause;; 
     
                       
     shell)
           cpu=$(gcc -dumpmachine)
           if [ $cpu == "x86_64-linux-gnu" ] 
          then
          for i in $(objdump -d /$path$nom_f'_x86' | grep '^ ' | sed 's/ //g' | awk -F"[\t]" {'print $2'});
            do echo -n ${i:14:2}${i:12:2}${i:10:2}${i:8:2}${i:6:2}${i:4:2}${i:2:2}${i:0:2};done|sed 's/.\{2\}/\\x&/g'   
            printf "Listo pulsar enter :) \n"
          fi
          
          if [ $cpu == "arm-linux-gnueabi" ]
          then
          for i in $(objdump -d /$path$nom_f'_arm' | grep '^ ' | sed 's/ //g' | awk -F"[\t]" {'print $2'});
            do echo -n ${i:6:2}${i:4:2}${i:2:2}${i:0:2};done|sed 's/.\{2\}/\\x&/g'   
            printf "Listo pulsar enter :) \n"
          fi
     
          pause;;   
  
     cpuinfo)
           printf 'Informacion del procesador es:-->'
           cat /proc/cpuinfo
           pause;;
   
     searh)
        printf "Ingrese plataforma windows linux arm android -->" 
        read plat
        printf "Ingrese programa ej pdf -->" 
        read prg
       
        searchsploit $prg $plat -w -t
        read;;

     v)
          return 0;;
     *)
          printf "Seleciona una opcion valida :)";
          pause;;          
  esac
        
done
