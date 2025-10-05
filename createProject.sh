# download commandline tools from 
#       https://developer.android.com/studio/index.html#downloads
#
# mkdir -p android-sdk/cmdline-tools
# unzip download into created folder
#
# alternative 
#   sudo apt-get install adb

if [ $# -lt 1 ]
then
    echo " projectname required "
    exit
fi

projectName=$1

mkdir ${projectName}
cd ${projectName}

mkdir -p src/com/${projectName}
mkdir obj
mkdir bin
mkdir -p res/layout
mkdir res/values
mkdir res/drawable
mkdir libs                      # for external libraries


touch  src/com/${projectName}/MainActivity.java

cat > src/com/${projectName}/MainActivity.java << _EOF_
package com.${projectName};

import android.app.Activity;
import android.os.Bundle;

public class MainActivity extends Activity {
   @Override
   protected void onCreate(Bundle savedInstanceState) {
      super.onCreate(savedInstanceState);
      setContentView(R.layout.activity_main);
   }
}
_EOF_


touch res/values/strings.xml

cat > res/values/strings.xml << _EOF_
<resources>
   <string name="app_name">${projectName}</string>
   <string name="hello_msg">${projectName}</string>
   <string name="menu_settings">Settings</string>
   <string name="title_activity_main">MainActivity</string>
</resources>
_EOF_


touch res/layout/activity_main.xml

cat > res/layout/activity_main.xml << _EOF_
<RelativeLayout 
    xmlns:android="http://schemas.android.com/apk/res/android" 
    xmlns:tools="http://schemas.android.com/tools"
    android:layout_width="match_parent"
    android:layout_height="match_parent" >
   
   <TextView
      android:layout_width="wrap_content"
      android:layout_height="wrap_content"
      android:layout_centerHorizontal="true"
      android:layout_centerVertical="true"
      android:text="@string/hello_msg"
      tools:context=".MainActivity" />
      
</RelativeLayout>
_EOF_


touch AndroidManifest.xml

cat > AndroidManifest.xml << _EOF_
<?xml version='1.0'?>
<manifest 
    xmlns:android='http://schemas.android.com/apk/res/android' 
    package='com.${projectName}' 
    android:versionCode='0' 
    android:versionName='0'>
    <application android:label='${projectName}'>
        <activity android:name='com.${projectName}.MainActivity'>
             <intent-filter>
                <category android:name='android.intent.category.LAUNCHER'/>
                <action android:name='android.intent.action.MAIN'/>
             </intent-filter>
        </activity>
    </application>
</manifest>
_EOF_


touch build.sh

cat > build.sh << _EOF_
#!/bin/bash

set -e

PROJECT=${projectName}
_EOF_

cat >> build.sh << '_EOF_'
export ANDROID_HOME="../android-sdk"
TOOLS_DIR="/build-tools/25.0.2"

export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
export PATH=$JAVA_HOME/bin:$PATH

AAPT=${ANDROID_HOME}${TOOLS_DIR}"/aapt"
DX=${ANDROID_HOME}${TOOLS_DIR}"/dx"
ZIPALIGN=${ANDROID_HOME}${TOOLS_DIR}"/zipalign"
APKSIGNER=${ANDROID_HOME}${TOOLS_DIR}"/apksigner" 
PLATFORM=${ANDROID_HOME}"/platforms/android-25/android.jar"
ADB=${ANDROID_HOME}"/platform-tools/adb"

echo " cleaning "
rm -rf obj/*
rm -rf src/com/${PROJECT}/R.java

echo " generating R.java file"
$AAPT package -f -m -J src -M AndroidManifest.xml -S res -I $PLATFORM

echo " compiling "
javac -d obj -classpath src -bootclasspath $PLATFORM -source 1.7 -target 1.7 src/com/${PROJECT}/MainActivity.java
javac -d obj -classpath src -bootclasspath $PLATFORM -source 1.7 -target 1.7 src/com/${PROJECT}/R.java

echo " translating in Dalvik bytecode "
$DX --dex --output=classes.dex obj

echo " making APK "
$AAPT package -f -m -F bin/${PROJECT}.unaligned.apk -M AndroidManifest.xml -S res -I $PLATFORM
$AAPT add bin/${PROJECT}.unaligned.apk classes.dex

echo " aligning APK "
$ZIPALIGN -f 4 bin/${PROJECT}.unaligned.apk bin/${PROJECT}.apk

echo " signing APK "
$APKSIGNER sign --ks mykey.keystore bin/${PROJECT}.apk

if [ "$1" == "I" ]; then
    echo " installing "
    ${ADB} install -r bin/${PROJECT}.apk
    ${ADB} shell am start -n com.${PROJECT}/.MainActivity
fi
_EOF_

chmod a+x build.sh

# if external libraries are used: 
#   exchange src after -classpath with "src:libs/<your-lib>.jar"
#   add libs/*.jar after $DX --dex --output=classes.dex before obj


keytool -genkeypair -validity 365 -keystore mykey.keystore -keyalg RSA -keysize 2048

