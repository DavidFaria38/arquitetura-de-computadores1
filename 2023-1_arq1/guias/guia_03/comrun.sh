#!/usr/bin/bash

 
#	COMpile and RUN
#	Obejtivo: compilar codigo e roda-lo usando uma entrada padrão e uma saida em arquivo

#	Step by step:
#		1. comrun FILE.v OUTPUT.txt 
#		2. iverilog -o .\FILE.vvp .\FILE.v
#		2. vvp .\FILE.vvp +NOME_DO_ARG=VALOR_ARG > OUTPUT.txt

DIR_OUTPUT="./output"

if [ -z $1 ] ; then 
	echo "O nome do arquivo deve ser passado no primeiro parametro: comrun NOME_ARQUIVO"
	exit
else
	FILE_NAME=$1
	COUNT_INPUT=0


	if [ -z $2 ] ; then
		OUTPUT_FILE="$DIR_OUTPUT/$FILE_NAME"_output
	else
		OUTPUT_FILE="$DIR_OUTPUT/$2"
	fi
	
	# criar diretorio para arquivos de output caso nao exista
	if [ ! -d $DIR_OUTPUT ] ; then 
		$(mkdir ./output)
	fi

	#remove output file
	if [ -e "$OUTPUT_FILE" ] ; then
		$(rm $OUTPUT_FILE)
	fi

	#remove .vvp extentios files
	$(rm *.vvp)
	
	#echo "FILE_NAME: $FILE_NAME"
	#echo "OUTPUT_FILE: $OUTPUT_FILE"


	# compile
	$(iverilog -o ./$FILE_NAME.vvp ./$FILE_NAME.v)
	# $(vvp ./$FILE_NAME.vvp $MY_ARGS >> $OUTPUT_FILE) # rodar programa sem nenhuma entrada do usuario
	
	echo "Input (ex: 1 2 3 => arg0=1, arg1=2, arg2=3):"
	read -a USER_INPUT
	while [ -n "$USER_INPUT" ] ; 
	do
		# contar quantas vezes o usuario inseriu um input
		let "COUNT_INPUT+=1"

		# transformar input do usuario para parametros que serão utilizados pelo programa 
		MY_ARGS=""
		USER_INPUT_STR=""
		for INDEX in "${!USER_INPUT[@]}";
		do
		  #echo "$INDEX : ${USER_INPUT[INDEX]}"
		  MY_ARGS+="+arg$INDEX=${USER_INPUT[INDEX]} "
		  USER_INPUT_STR+="${USER_INPUT[INDEX]} "
		done
		# echo $MY_ARGS
	
		$(echo -e "User Input: $USER_INPUT_STR" >> $OUTPUT_FILE)
		$(echo -e "Output:" >> $OUTPUT_FILE)
		$(vvp ./$FILE_NAME.vvp $MY_ARGS >> $OUTPUT_FILE)
		$(echo -e "===============================================================\n" >> $OUTPUT_FILE)
		
		echo "Input:"
		read -a USER_INPUT
	done

	echo "comrun.sh: DONE"
	echo "Vá em \"$OUTPUT_FILE\" para ler o output."
	echo "O usuario inseriu $COUNT_INPUT input(s)."
fi