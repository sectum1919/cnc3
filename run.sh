#！/bin/bash
#This is the pipeline for cn-celeb database creation

stage=0

Name_list_path='/work9/cchen/project/CNCeleb/cnc3/people.xls'
img_path='/work9/cchen/project/CNCeleb/cnc3/logs/pictures/test'

input_video_path='/work9/cchen/project/CNCeleb/cnc3/data/original-data/'
output_video_path='/work9/cchen/project/CNCeleb/cnc3/data/transcoded-data/'

syncnet_output_dir='/work9/cchen/project/CNCeleb/cnc3/logs/syncnet_result/'
wav_output_dir='/work9/cchen/project/CNCeleb/cnc3/logs/wav_result/'
sysp_output_dir='/work9/cchen/project/CNCeleb/cnc3/logs/sysp_result/'

final_output_dir='/work9/cchen/project/CNCeleb/cnc3/data/final_data/'

# Example
# Name_list_path='${data_path}/${batch_name}.xls'
# img_path='${data_path}/logs/pictures/${batch_name}/'

# input_video_path='${data_path}/data/original-data/${batch_name}/'
# output_video_path='${data_path}/data/transcoded-data/${batch_name}/'

# syncnet_output_dir='${data_path}/logs/syncnet_result/${batch_name}/'
# wav_output_dir='${data_path}/logs/wav_result/${batch_name}/'
# sysp_output_dir='${data_path}/logs/sysp_result/${batch_name}/'

# final_output_dir='${data_path}/data/final_data/${batch_name}/'


#Download pictures of pois from the list
#Name_list_path:Location of the excel file
#img_path：Where the pictures are saved
if [ $stage -le 0 ]; then
echo getpoi
cd getpoi
#path1=$(echo `cd $Name_list_path; pwd`)
#path2=$(echo `cd $img_path; pwd`)
python getpoi.py $Name_list_path $img_path
echo getpoi done
cd ..
fi


#Transframe the original data to 25 frames
#Optional: when the program has a problem and exits, restart from xxx, eliminating the time wasted running from the beginning
if [ $stage -le 1 ]; then
echo transcoding
cd tools
python transcoding.py $input_video_path $output_video_path 
echo transcoding done
cd ..
fi



#Face recognition program
#You can modify starting poi at line 411 of the main program
#Modify the gpu selection in common.py
if [ $stage -le 2 ]; then
echo syncnent
cd videoprocess
python run.py
echo syncnent done
cd ..
fi

#Speaker recognition program
#You can modify starting poi at line 270 of the main program
if [ $stage -le 3 ]; then
echo speaker
cd speaker-Diarization
python speakerDiarization.py  
echo speaker done
cd ..
fi

if [ $stage -le 4 ]; then
echo predict
cd speaker-Diarization
python predict.py
echo predict done
cd ..
fi


#Video segmentation
if [ $stage -le 5 ]; then
echo split
cd tools
sh split.sh $output_video_path $sysp_output_dir $final_output_dir
echo split done
echo all finished
cd ..
fi
