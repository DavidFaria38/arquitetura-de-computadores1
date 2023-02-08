#!/usr/bin/bash

 
#	COMpile and RUN
#	Obejtivo: compilar codigo e roda-lo usando uma entrada padrão e uma saida em arquivo

#	Step by step:
#		1. comrun FILE.v INPUT.txt 
#		2. iverilog -o .\FILE.vvp .\FILE.v
#		2. vvp .\FILE.vvp +NOME_DO_ARG=VALOR_ARG > OUTPUT.txt


if [ -z $1 ] ; then 
	echo "O nome do arquivo deve ser passado no primeiro parametro: comrun NOME_ARQUIVO"
	exit
else
	FILE_NAME=$1

	if [ -z $2 ] ; then
		OUTPUT_FILE="$FILE_NAME"_output
	else
		OUTPUT_FILE=$2
	fi

	#echo "FILE_NAME: $FILE_NAME"
	#echo "OUTPUT_FILE: $OUTPUT_FILE"
	
	# compile
	#$(iverilog -o ./$FILE_NAME.vvp ./$FILE_NAME.v)
	#clear output file
	#$(rm $OUTPUT_FILE)
	
	read -a USER_INPUT
	while [ -n $USER_INPUT ] ; 
	do
		# transformar input do usuario para parametros que serão utilizados pelo programa 
		MY_ARGS=""
		for INDEX in "${!USER_INPUT[@]}";
		do
		  #echo "$INDEX : ${USER_INPUT[INDEX]}"
		  MY_ARGS+="+arg$INDEX=${USER_INPUT[INDEX]}"
		done
		#echo $MY_ARGS
	
		$(echo -e "User Input: $USER_INPUT" >> $OUTPUT_FILE)
		$(echo -e "Output:" >> $OUTPUT_FILE)
		$(vvp ./$FILE_NAME.vvp $MY_ARGS >> $OUTPUT_FILE)
		$(echo -e "===============================================================\n" >> $OUTPUT_FILE)
		read -a USER_INPUT
	done
fi
