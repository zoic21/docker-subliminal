#!/bin/bash
echo 'Start init'

if [ -z ${ROOT_PASSWORD} ]; then
	echo "Use default password : root"
	echo "root:root" | chpasswd
else
	echo "root:${ROOT_PASSWORD}" | chpasswd
fi

if [ -d /root/subliminal ]; then
    cd /root/subliminal
    git reset --hard HEAD
    git pull
else
   cd /root
   git clone --depth 1 https://github.com/Diaoul/subliminal.git
fi

rm /root/subliminal/subliminal.py
cp /root/subliminal.py /root/subliminal/subliminal.py

if [ -z ${LANG} ]; then
	LANG=fra
fi

if [ -z ${WEEK} ]; then
	WEEK=2
fi

if [ -z ${CRON} ]; then
	CRON='00 00 * * *'
fi

(echo "${CRON} su --shell=/bin/bash - www-data -c 'python /root/subliminal/subliminal.py -l ${LANG} -w ${WEEK}' >> /dev/null"; crontab -l | grep -v "subliminal") | crontab -

/usr/bin/supervisord

