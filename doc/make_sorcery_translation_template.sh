#!/bin/sh
#~ echo "translator name ?"
#~ read
#~ TRANSLATOR="$REPLY"
#~ echo "translator email ?"
#~ read
#~ EMAIL="$REPLY"
#~ REVISION="$(date)"
#~ echo "language team ? (empty for translator name)"
#~ read
#~ TEAM="${REPLY:=$TRANSLATOR}"
#~ echo "language team email? (empty for translator email)"
#~ read
#~ TEAMEMAIL="${REPLY:=$EMAIL}"

IFS=$'\n'

DIR="pot/${LANG}/LC_MESSAGES/"
mkdir -p $DIR &&

for FILE in $(find $1 -type f -perm +u+x)
do
	FILE_WITHOUT_PATH=$(echo $FILE |sed "s:^.*/::")
	if xgettext -L Shell -o $DIR/$FILE_WITHOUT_PATH.po $FILE  && [ -f $DIR/$FILE_WITHOUT_PATH.po ]; then 
		sed -i "s/Copyright (C) YEAR/Copyright (C) $(date +%Y)/" $DIR/$FILE_WITHOUT_PATH.po
		sed -i "s/THE PACKAGE'S COPYRIGHT HOLDER/Kyle Sallee, all rights reserved/" $DIR/$FILE_WITHOUT_PATH.po
		sed -i "s/license as the PACKAGE package./license as the sorcery package./" $DIR/$FILE_WITHOUT_PATH.po
		#sed -i "s/FIRST AUTHOR <EMAIL@ADDRESS>, YEAR./$TRANSLATOR <$EMAIL>, $(date +%Y)/" $DIR/$FILE_WITHOUT_PATH.po
		sed -i "s/PACKAGE VERSION/sorcery $(augur version sorcery)/" $DIR/$FILE_WITHOUT_PATH.po
		#sed -i "s/Report-Msgid-Bugs-To: \n/Report-Msgid-Bugs-To: $EMAIL, kyle\n/" $DIR/$FILE_WITHOUT_PATH.po
		#sed -i "s/Last-Translator: FULL NAME <EMAIL@ADDRESS>\n/Last-Translator: $TRANSLATOR <$EMAIL>/" $DIR/$FILE_WITHOUT_PATH.po
		sed -i "s/charset=CHARSET/charset=UTF-8/" $DIR/$FILE_WITHOUT_PATH.po
		sed -i "s/LANGUAGE <LL@li.org>/sorcery-${LANG}-team <EMAIL>/" $DIR/$FILE_WITHOUT_PATH.po
		#sed -i "s/LANGUAGE <LL@li.org>/sorcery-${LANG}-team <$EMAIL>/" $DIR/$FILE_WITHOUT_PATH.po
	fi
done
