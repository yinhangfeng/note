```
修改adb的默认端口
http://bbs.csdn.net/topics/390870699

下载文件
adb pull [文件名] /源路径/
例如：
adb pull blade_keypad.kl /system/usr/keylayout/
adb pull /sdcard/mp3/1.mp3
上传文件
adb push [文件名] /目标路径/
例如：
adb push qwerty.kl /system/usr/keylayout/
adb push 1.mp3 /sdcard/mp3/
安装程序
adb install -r [/路径/软件名.apk]
例如：adb install -r com.android.vending.apk
adb install -r com.android.vending.apk

获取当前运行的activity
adb shell dumpsys activity | grep "mFocusedActivity"
dumpsys activity top

调试已安装的app(在启动时就开始调试)
adb shell am set-debug-app -w com.example.xxx
```
