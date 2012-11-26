cd /data/app
for app in `find . -name '*.odex'`
do
	if [ ! -f `echo $app | sed 's/\(.*\.\)odex/\1apk/'` ]
	then
		rm $app
	fi
done;
cd /data/app

for app in `find . -name '*.apk'`
do
	/system/bin/dexopt-wrapper $app `echo $app | sed 's/\(.*\.\)apk/\1odex/'`
	if [ -f `echo $app | sed 's/\(.*\.\)apk/\1odex/'` ]
	then
		/system/bin/zip -d $app classes.dex
		/system/bin/zipalign -f -v 4 $app $app.new
		mv $app.new $app
	fi
done;
echo cleanup
rm -f  /data/dalvik-cache/*
sleep 5