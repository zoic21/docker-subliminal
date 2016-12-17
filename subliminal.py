#!/usr/bin/python

import sys
from datetime import timedelta
from babelfish import Language
from subliminal import download_best_subtitles, region, save_subtitles, scan_videos

for opt, arg in opts:
	if opt in ("-l"):
		lang = arg
	elif opt in ("-w"):
		week = arg

# configure the cache
region.configure('dogpile.cache.dbm', arguments={'filename': 'cachefile.dbm'})

# scan for videos newer than 2 weeks and their existing subtitles in a folder
videos = scan_videos('/tvshows', age=timedelta(weeks=week))

# download best subtitles
subtitles = download_best_subtitles(videos, {Language(lang)})

# save them to disk, next to the video
for v in videos:
    save_subtitles(v, subtitles[v])