
from androguard.core.bytecodes.apk import APK


# ��ȡ����
# apk:apk��װ����·��
# ���ذ���
def get_apkname(apk) :
    a = APK ( apk , False , "r" )
    return a.get_package ()


# ��ȡ����activity
# apk:apk��װ����·��
# ��������activity
def get_apk_lautc(apk) :
    a = APK ( apk , False , "r" )
    return a.get_main_activity ()



