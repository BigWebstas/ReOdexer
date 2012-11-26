if [ -f /data/local/tmp/TempApp.odex ]
then
	rm /data/local/tmp/TempApp.odex
fi
BOOTCLASSPATH=/system/framework/core.jar:/system/framework/core-junit.jar:/system/framework/bouncycastle.jar:/system/framework/ext.jar:/system/framework/framework.jar:/system/framework/framework2.jar:/system/framework/framework_ext.jar:/system/framework/android.policy.jar:/system/framework/services.jar:/system/framework/apache-xml.jar:/system/framework/sec_edm.jar:/system/framework/seccamera.jar
cd /system/framework
for app in core.jar core-junit.jar bouncycastle.jar ext.jar framework.jar framework2.jar framework_ext.jar android.policy.jar services.jar apache-xml.jar sec_edm.jar seccamera.jar
do
	name=`basename $app .jar`
	echo $name
	if [ -f $app ]
	then
		if [ ! -f $name.odex ]
		then 
			echo $app
			/system/bin/dexopt-wrapper $app /data/local/tmp/TempApp.odex $BOOTCLASSPATH
			if [ $? -eq 0 ]
			then
				/system/bin/zip -d $app classes.dex
				cp /data/local/tmp/TempApp.odex $name.odex
				rm /data/local/tmp/TempApp.odex
				chmod 644 $name.odex
			else
				rm /data/local/tmp/TempApp.odex
			fi
		fi
	fi
done
cd /system/framework
for app in *.jar
do
	name=`basename $app .jar`
		if [ ! -f $name.odex ]
		then 
			echo $app
			/system/bin/dexopt-wrapper $app /data/local/tmp/TempApp.odex $BOOTCLASSPATH
			if [ $? -eq 0 ]
			then
				/system/bin/zip -d $app classes.dex
				cp /data/local/tmp/TempApp.odex $name.odex
				rm /data/local/tmp/TempApp.odex
				chmod 644 $name.odex
			else
				rm /data/local/tmp/TempApp.odex
			fi
		fi
done

