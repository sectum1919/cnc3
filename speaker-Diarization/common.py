# -*-coding:utf-8-*-
class Config:
    SAVED_MODEL_NAME = 'pretrained/saved_model.uisrnn_benchmark'
    video_base_dir = '/work9/cchen/project/CNCeleb/cnc3/data/transcoded-data/'#转帧后的视频路径 ${output_video_path} in run.sh
    output_dir = '/work9/cchen/project/CNCeleb/cnc3/logs/sysp_result/'  #speaker输出结果 ${sysp_output_dir} in run.sh
    SyncNet_result_dir = '/work9/cchen/project/CNCeleb/cnc3/logs/syncnet_result/' # ${syncnet_output_dir} in run.sh
    temp_dir = './temp'
    log_dir = './log'
   # final_output_dir = '/work5/cslt/fanyue/cn-celeb2/logs/sysp_result/part6'
    model_dir = './ckpt/'
    graph_dir = './ckpt/logistic.ckpt-80000.meta'

    # 0: 根据两边阈值挑选
    # 1: 对两边距离做运算
    merge_method = 0

config = Config()
