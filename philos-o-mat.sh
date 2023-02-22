#!/bin/bash

MAT_LANG=${MAT_LANG:-en}
MAT_ROOT=$( dirname -- "$0"; )
MAT_FILE=$MAT_ROOT/library_${MAT_LANG}.txt

MAT_TOPICS=()
MAT_ADVERBS=()
MAT_DEPICTIONS=()

while IFS= read -r line
do 
    if [ -n "$line" ]
    then
        TYPE=${line:0:1}
        TXT=${line:2}
        if [ $TYPE == "#" ]
        then # ignore line
            sleep 0
        elif [ $TYPE == "t" ] 
        then
            MAT_TOPICS+=("$TXT")
        elif [ $TYPE == "a" ]
        then
            MAT_ADVERBS+=("$TXT")
        elif [ $TYPE == "d" ]
        then
            MAT_DEPICTIONS+=("$TXT")
        fi
    fi
done < $MAT_FILE

R=$RANDOM
let R%=${#MAT_TOPICS[*]}
MAT_TOPIC=${MAT_TOPICS[$R]}
R=$RANDOM
let R%=${#MAT_ADVERBS[*]}
MAT_ADVERB=${MAT_ADVERBS[$R]}
R=$RANDOM
let R%=${#MAT_DEPICTIONS[*]}
MAT_DEPICTION=${MAT_DEPICTIONS[$R]}

PRE=""
POST=""
if [[ "$TERM" =~ "xterm" ]]; then
  PRE="\033[3m"
  POST="\033[23m"
fi
echo -e "${PRE}„$MAT_TOPIC $MAT_ADVERB $MAT_DEPICTION.“ — Philos-O-Mat$POST"