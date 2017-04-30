#!/bin/bash 


PQRC="./result"

FIC="$PQRC/icone.qrc"
FBG="$PQRC/background.qrc"

PTREE="./tree"
PSOUND=$PTREE"/sound"
PPIC=$PTREE"/background"
PICO=$PTREE"/ico"
PPLAY=$PICO"/play"
PPAUSE=$PICO"/pause"
PSTOP=$PICO"/stop"
PBACK=$PICO"/back"
POTHER=$PICO"/other"
PLARROW=$PICO"/left_arrow"
PRARROW=$PICO"/right_arrow"
PTEXT=$PTREE"/text"
PTEXTAR=$PTEXT"/textarea"
PTITRE=$PTEXT"/titre"

function create_file_txt {
FILEPATH=$1
FILENAME=$2
SEARCHFOLDER=$3
ALIAS_COUNT=0
FULLNAME=""
PREFIX=$4
FULLNAME=$FILEPATH'/'$FILENAME".qrc"
ALIASNAME=$5

	touch $FULLNAME
	echo "<RCC>" >> $FULLNAME
	echo -e "\t<qresource prefix=\"$PREFIX\">" >> $FULLNAME

	for file in $SEARCHFOLDER/*.*
	do
		echo "adding $file to ressources"
		echo -e "\t\t<file alias=\"$ALIASNAME$ALIAS_COUNT\">${file:2}</file>" >> $FULLNAME
		let "ALIAS_COUNT += 1"
	done

	echo -e "\t</qresource>" >> $FULLNAME
	echo "</RCC>" >> $FULLNAME

}

function create_file {
FILEPATH=$1
FILENAME=$2
SEARCHFOLDER=$3
ALIAS_COUNT=0
FILE_COUNT=0
FULLNAME=""
PREFIX=$4
ALIASNAME=$5
	for file in $SEARCHFOLDER/*.*
	do
		if [ $(($ALIAS_COUNT%2)) -eq 0 ]
		then
			if [ -f "$FULLNAME" ]
			then
				echo -e "\t</qresource>" >> $FULLNAME
				echo "</RCC>" >> $FULLNAME
			fi
			FULLNAME=$FILEPATH'/'$FILENAME$FILE_COUNT".qrc"
			touch $FULLNAME
			echo "<RCC>" >> $FULLNAME
			echo -e "\t<qresource prefix=\"$PREFIX\">" >> $FULLNAME
			let "FILE_COUNT += 1";
		fi
		echo "adding $file to ressources"
		echo -e "\t\t<file alias=\"$ALIASNAME$ALIAS_COUNT\">${file:2}</file>" >> $FULLNAME
		let "ALIAS_COUNT += 1"
	done
	echo -e "\t</qresource>" >> $FULLNAME
	echo "</RCC>" >> $FULLNAME

}


if [ "$1" == "-h" ] || [ "$1" == "" ]
then
	echo -e "usage : ./qrc_creator.sh \n\t-create : create ressources tree\n\t-exec : create qrc file\n\t -exec-rar : voir (-exec) avec compression"
elif [ "$1" == "-create" ] || [ "$1" == "-c" ]
then
	
	echo "create tree : $PTREE"
	mkdir $PTREE
	echo "create sound directory : $PSOUND"
	mkdir $PSOUND
	echo "create background directory : $PPIC"
	mkdir $PPIC
	echo "create icone directory : $PICO"
	mkdir $PICO
	mkdir $PPLAY
	mkdir $PPAUSE
	mkdir $PSTOP
	mkdir $PLARROW
	mkdir $PRARROW
	mkdir $PBACK
	mkdir $POTHER

	mkdir $PTEXT
	mkdir $PTEXTAR
	mkdir $PTITRE

tree $PTREE
#	echo -e "$(PSOUND)"
elif [ "$1" == "-exec" ] || [ "$1" == "-e" ] || [ "$1" == "-exec-rar" ]
then
	if [ -e "$PQRC" ]
	then
		rm -r $PQRC
	fi
		mkdir $PQRC
# ============= start ICONE FILE ======= #
	if [ -f "$FIC" ]
	then
		rm $FIC
	fi
	touch $FIC
	echo "<RCC>" >> $FIC
	COUNT=0;
	echo -e "\t<qresource prefix=\"/icone\">" >> $FIC
	for file in $PPLAY/*.*
	do
		if [ -f "$file" ]
		then
			echo "adding $file to ressources"
			echo -e "\t\t<file alias=\"PLAY$COUNT\">${file:2}</file>" >> $FIC
			let "COUNT += 1"
		fi
	done

	COUNT=0;
	for file in $PPAUSE/*.*
	do
		if [ -f "$file" ]
		then
			echo "adding $file to ressources"
			echo -e "\t\t<file alias=\"PAUSE$COUNT\">${file:2}</file>" >> $FIC
			let "COUNT += 1"
		fi
	done

	COUNT=0;
	for file in $PSTOP/*.*
	do
		if [ -f "$file" ]
		then
			echo "adding $file to ressources"
			echo -e "\t\t<file alias=\"STOP$COUNT\">${file:2}</file>" >> $FIC
			let "COUNT += 1"
		fi
	done

	COUNT=0;
	for file in $PLARROW/*.*
	do
		if [ -f "$file" ]
		then
			echo "adding $file to ressources"
			echo -e "\t\t<file alias=\"LARROW$COUNT\">${file:2}</file>" >> $FIC
			let "COUNT += 1"
		fi
	done

	COUNT=0;
	for file in $PBACK/*.*
	do
			if [ -f "$file" ]
			then
			echo "adding $file to ressources"
			echo -e "\t\t<file alias=\"BACK$COUNT\">${file:2}</file>" >> $FIC
			let "COUNT += 1"
		fi
	done

	COUNT=0;
	for file in $PRARROW/*.*
	do
		if [ -f "$file" ]
		then
			echo "adding $file to ressources"
			echo -e "\t\t<file alias=\"RARROW$COUNT\">${file:2}</file>" >> $FIC
			let "COUNT += 1"
		fi
	done

	COUNT=0;
	for file in $POTHER/*.*
	do
		if [ -f "$file" ]
		then
			echo "adding $file to ressources"
			echo -e "\t\t<file alias=\"OTHER$COUNT\">${file:2}</file>" >> $FIC
			let "COUNT += 1"
		fi
	done
echo -e "\t</qresource>" >> $FIC
echo "</RCC>" >> $FIC

# ============= START BG FILE ======= #
	if [ -f "$FBG" ]
	then
		rm $FBG
	fi
	touch $FBG
	echo "<RCC>" >> $FBG
	COUNT=0;
	echo -e "\t<qresource prefix=\"/background\">" >> $FBG
	for file in $PPIC/*.*
	do
		if [ -f "$file" ]
		then
			echo "adding $file to ressources"
			echo -e "\t\t<file alias=\"BG$COUNT\">${file:2}</file>" >> $FBG
			let "COUNT += 1"
		fi
	done
	
	echo -e "\t</qresource>" >> $FBG
	echo "</RCC>" >> $FBG

	create_file $PQRC audio $PSOUND /sound SOUND
	create_file_txt $PQRC titre $PTITRE /texte T
	create_file_txt $PQRC textarea $PTEXTAR /texte TA

fi

if [ "$1" == "-exec-rar" ]
then
	tar -cf qrc.rar $PQRC/*.qrc tree
fi
