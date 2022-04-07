import os

def get_devices():
    cmd="adb devices"
    reslut=os.popen(cmd).readlines()
    print(reslut)

get_devices()