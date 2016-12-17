#!/bin/bash
echo 'Start init'

if [ -d /root/subliminal ]; then
    cd /root/subliminal
    git reset --hard HEAD
    git pull
else
   cd /root
   git clone --depth 1 https://github.com/Diaoul/subliminal.git
fi

cd /root/subliminal
python setup.py install

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

