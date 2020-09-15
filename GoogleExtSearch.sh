#!/bin/bash

######Cores pra melhorar o Output######
RED='\033[31;1m'
GREEN='\033[32;1m'
BLUE='\033[34;1m'
YELLOW='\033[33;1m'
RED_BLINK='\033[31;5;1m'
END='\033[m'

if [[ $1 == "" || $2 == "" ]]
	then	
		echo -e "${YELLOW}======================================================="
		echo -e "Modo de uso: ./$0 dominio.exemplo.com ext"
		echo -e "======================================================="
		echo -e "Exemplos de extensoes: pdf|xml|doc|docx|sql|xls"
		echo -e "=======================================================${END}"
else
	lynx --dump "google.com/search?q=site:$1+ext:$2" | grep "\.$2" | cut -d "=" -f2 | sed "s/...$//" > temp.pdm
	if [[ $(cat temp.pdm) == '' ]]
		then
		echo ""
		echo -e "${RED_BLINK}[-] Nenhum arquivo encontrado [-]${END}"
		echo ""
	else
		echo -e "${GREEN}========Arquivos encontrados=========\n"
		cat temp.pdm
		echo -e "\n=====================================\n${END}"
		
		echo -e "[+] Deseja ler os metadados dos arquivos encontrados?(y/n): "
		read resposta
			if [[ $resposta == "y" || $resposta == "Y" ]]
				then
				for linha in $(cat temp.pdm);do
					echo -e "${BLUE}\n[Downloading...] Baixando arquivo no endereço $linha ${END}\n"
					wget $linha 2> /dev/null;done

				echo -e "|+|---------------------------------------|+| ${GREEN}\n"
				exiftool *.$2 
				echo -e "\n${END}|+|---------------------------------------|+| \n"
				
			fi
		rm temp.pdm
	fi
fi