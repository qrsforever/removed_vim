rm apk-tool -rf
rm apk-decode -rf
rm apk-unzip -rf
rm dex2jar -rf

rm jd-gui.jar -f

VIM_HOME="$HOME/.vim"
APKTOOL="$VIM_HOME/project/android/tools/apktool/apktool"
DEX2JAR="$VIM_HOME/project/android/tools/dex2jar/d2j-dex2jar.sh"

$APKTOOL d -f $1 -o apk-decode
unzip -x $1 -d apk-unzip
$DEX2JAR -f apk-unzip/classes.dex -o dex2jar/classes.jar 

ln -s $VIM_HOME/project/android/tools/jd-gui/jd-gui-1.4.0.jar jd-gui.jar