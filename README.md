# CNCeleb3

## Environments

python version 2.7.12

conda导出的yml文件为env.yml，可以使用命令`conda create -n {env_name} -f env.yml`创建虚拟环境

同时提供了pip freeze导出的requirements.txt，如果conda创建不成功可以手动安装某些包

## Path to modify

需要修改以下位置的路径以成功运行：

| filename | line |
| - | - |
| run.sh | line 6~16 |
| getpoi/getpoi.py | line 25 |
| speaker-Diarization/common.py | line 4~6 |
| videoprocess/common.py | line 11~19 |

## Model to download

下载 [20180402-114759/](https://cloud.tsinghua.edu.cn/d/8c454b96e9ea48698845) 到 `getpoi/facenet_code/20180402-114759/`