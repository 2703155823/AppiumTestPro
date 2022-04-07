
from androguard.core.bytecodes.apk import APK


# 获取包名
# apk:apk安装包的路径
# 返回包名
def get_apkname(apk) :
    a = APK ( apk , False , "r" )
    return a.get_package ()


# 获取启动activity
# apk:apk安装包的路径
# 返回启动activity
def get_apk_lautc(apk) :
    a = APK ( apk , False , "r" )
    return a.get_main_activity ()



