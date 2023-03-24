# prelinger-tests



Scale with ffmpeg - Local Docker Test
```
#docker run --rm -it -v $PWD/inputs:/inputs --entrypoint /bin/bash linuxserver/ffmpeg 
export INPUTFILENAME=Fridgidaire_Final_001_4444HQ_800x600.mov
export OUTPUTFILENAME=Fridgidaire_Final_001_4444HQ_150x100.mov
mkdir -p outputs
docker run --rm -v $PWD/inputs:/inputs -v $PWD/outputs:/outputs\
    linuxserver/ffmpeg \
    -i /inputs/${INPUTFILENAME} -vf scale=150:100 \
    /outputs/${OUTPUTFILENAME}
```


Scale with ffmpeg - On Bacalhau
```
# Inputs folder IPFS CID: bafybeiazxxfknpzdwkbkbgwwgrvnw5yr2zfn4d6iqjtxk5dkwm3sd5aexi
export INPUTFILENAME=Fridgidaire_Final_001_4444HQ_800x600.mov
export OUTPUTFILENAME=Fridgidaire_Final_001_4444HQ_150x100.mov

bacalhau docker run \
    -v bafybeiazxxfknpzdwkbkbgwwgrvnw5yr2zfn4d6iqjtxk5dkwm3sd5aexi:/inputs \
    linuxserver/ffmpeg \
    -- -i /inputs/${INPUTFILENAME} -vf scale=150:100 \
    /outputs/${OUTPUTFILENAME}

```








#Object detection with Yolo
--input-urls https://github.com/ultralytics/yolov5/releases/download/v6.2/yolov5s.pt \
ultralytics/yolov5:v6.2 \
-- /bin/bash -c 'find /inputs -type f -exec cp {} /outputs/yolov5s.pt \; ; python detect.py --weights /outputs/yolov5s.pt --source $(pwd)/data/images --project /outputs'

#Easy OCR
#https://docs.bacalhau.org/examples/model-inference/EasyOCR/
--wait \
jsacex/easyocr \
--  easyocr -l ch_sim  en -f ./inputs/chinese.jpg --detail=1 --gpu=True








#Convert
#ffmpeg -i my-video.mov -vcodec h264 -acodec mp2 my-video.mp4
#ffmpeg -i Fridgidaire_Final_001_4444HQ_4096x3072.mov -vcodec h264 -acodec mp2 Fridgidaire_Final_001_4444HQ.mp4
#Trim
#ffmpeg -i input.mp4 -ss 00:05:20 -t 00:10:00 -c:v copy -c:a copy output1.mp4
#Probe the file's resolutions
#ffprobe <input-file>