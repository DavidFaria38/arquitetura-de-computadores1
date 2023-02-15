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

	#clear output file
	if [ -e "$OUTPUT_FILE" ] ; then
		$(rm $OUTPUT_FILE)
	fi

	#echo "FILE_NAME: $FILE_NAME"
	#echo "OUTPUT_FILE: $OUTPUT_FILE"
	$(rm *.vvp)

	# compile
	$(iverilog -o ./$FILE_NAME.vvp ./$FILE_NAME.v)

	echo "Input (ex: 1 2 3 => arg0=1, arg1=2, arg2=3):"
	read -a USER_INPUT
	while [ -n "$USER_INPUT" ] ; 
	do
		# contar quantas vezes o usuario inseriu um input
		let "COUNT_INPUT+=1"

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
		
		echo "Input:"
		read -a USER_INPUT
	done

	echo "comrun.sh: DONE"
	echo "Vá em \"$OUTPUT_FILE\" para ler o output."
	echo "O usuario inseriu $COUNT_INPUT input(s)."
fi
