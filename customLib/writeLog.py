# 添加依赖包
import os
import time


def Create_Log(dir_name, name, msg):
    desktop_path = './' + dir_name + '/'
    # 判断文件夹是否存在，不存在则创建
    if not os.path.exists(desktop_path):
        os.mkdir(desktop_path)
    # 判断文件是否被创建，不存在则创建;创建了，就追加内容
    file_path = desktop_path + name + '.log'
    if not os.path.exists(file_path):
        file = open(file_path, 'w+')
        timer = time.strftime("%Y年%m月%d日 %H时%M分%S秒", time.localtime())
        msg = timer + ' *** ' + msg
    else:
        file = open(file_path, 'a+')
        timer = time.strftime("%Y年%m月%d日 %H时%M分%S秒", time.localtime())
        msg = '\n' + timer + ' *** ' + msg
    file.write(msg)
    file.close()

def write_Runlog(message):
    Create_Log('log', 'Runlog', message)  # 调用函数

def write_Errlog(message):
    Create_Log('log', 'Errlog', message)  # 调用函数
