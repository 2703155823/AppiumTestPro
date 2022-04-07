import os


def get_devices() -> list :
    all_devices = []
    cmd = "adb devices"
    reslut = os.popen ( cmd ).readlines ()[1 :]
    for item in reslut :
        if item != "\n" :
            all_devices.append ( str ( item ).split ( "\t" )[0] )
    return all_devices


def getPlatForm(dev: str) -> str :
    cmd = 'adb -s {} shell getprop ro.build.version.release'.format ( dev )
    reslut = os.popen ( cmd ).readlines ()[0]
    return str ( reslut ).split ( "\n" )[0]


def isinstallapk(packname: str , devname: str) -> bool :
    cmd = "adb -s {} shell pm list packages -3".format ( devname )
    reslut = os.popen ( cmd ).readlines ()
    all_apkname = []
    for i in reslut :
        apkname = str ( i ).split ( '\n' )[0].split ( ":" )[1]
        all_apkname.append ( apkname )
    if packname in all_apkname :
        return True
    return False


def uninstallapk(packname: str , devname: str) -> bool :
    cmd = "adb -s {} shell pm list packages -3".format ( devname )
    reslut = os.popen ( cmd ).readlines ()
    all_apkname = []
    for i in reslut :
        apkname = str ( i ).split ( '\n' )[0].split ( ":" )[1]
        all_apkname.append ( apkname )
    if packname in all_apkname :
        cmd = 'adb -s %s uninstall %s ' % (devname , packname)
        os.system ( cmd )
        return True
    return False


def installapk(paknamepath: str , devname: str) -> bool :
    cmd = 'adb -s %s install %s' % (devname , paknamepath)
    os.system ( cmd )
    return True
