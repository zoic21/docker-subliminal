#!/usr/bin/python

import sys, getopt
from datetime import timedelta
from babelfish import Language
from subliminal import download_best_subtitles, region, save_subtitles, scan_videos

opts, args = getopt.getopt(sys.argv[1:],'l:w:')

for opt, arg in opts:
        if opt in ("-l"):
                lang = arg
        elif opt in ("-w"):
                week = int(arg)

print 'Searching subtitle into /tvshows for langue '+str(lang)+' and series less '+str(week)+' week';

region.configure('dogpile.cache.dbm', arguments={'filename': 'cachefile.dbm'})
videos = scan_videos('/tvshows', age=timedelta(weeks=week))
subtitles = download_best_subtitles(videos, {Language(lang)})
for v in videos:
    save_subtitles(v, subtitles[v])
