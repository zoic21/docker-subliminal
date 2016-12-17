#!/bin/bash
echo 'Start init'

if [ -z ${ROOT_PASSWORD} ]; then
	echo "Use default password : root"
	echo "root:root" | chpasswd
else
	echo "root:${ROOT_PASSWORD}" | chpasswd
fi

if [ -z ${LANG} ]; then
	LANG=fra
fi

if [ -z ${WEEK} ]; then
	WEEK=2
fi

(echo "00 00 * * * su --shell=/bin/bash - www-data -c 'python /root/subliminal.py -l ${LANG} -w ${WEEK}' >> /dev/null"; crontab -l | grep -v "subliminal" | crontab -

/usr/bin/supervisord

