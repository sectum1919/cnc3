from moviepy.editor import *
import sys
import os
import cv2
import shutil


def transcoding(video_dir, output_dir):
    print(output_dir)
    cap = cv2.VideoCapture(video_dir)
    if cap.get(cv2.CAP_PROP_FPS) == 25:
        shutil.copyfile(video_dir, output_dir)
        return
    clip = VideoFileClip(video_dir)
    clip.write_videofile(output_dir, verbose=False, fps=25)


if __name__ == '__main__':
    argnum = len(sys.argv)
    print(argnum)
    if argnum != 3 and argnum != 4:
        print("args are not valid")
        exit(1)
    top_dir = sys.argv[1]
    output_top_dir = sys.argv[2]
    if not os.path.exists(top_dir):
        print("cannot find origin videos")
        exit(1)
    if not os.path.exists(output_top_dir):
        os.makedirs(output_top_dir)
    names = os.listdir(top_dir)
    i = 0
    if argnum == 4:
        while names[i] != sys.argv[3]:
            i += 1
    for name in names[i:]:
        types = os.listdir(os.path.join(top_dir, name))
        for type in types:
            output = os.path.join(output_top_dir, name, type)
            if not os.path.exists(output):
                os.makedirs(output)
            for root, dirs, files in os.walk(os.path.join(top_dir, name, type)):
                i = 1
                for file in files:
                    if file.find('.MP4') > 0 or file.find('.mp4') > 0:
                        filename = type + "-" + str(i) + ".mp4"
                        try:
                            transcoding(os.path.join(root, file), os.path.join(output, filename))
                            i = i + 1
                        except:
                            continue
                    else:
                        continue
    print("complete")
