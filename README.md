# Prelinger Decentralized Video Processing Pipeline with Project Bacalhau
https://archive.org/details/prelinger
https://bacalhau.org/

# Scale with ffmpeg - Local Docker Test
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


# Scale with ffmpeg - On Bacalhau
```
# Inputs folder IPFS CID: bafybeihjplsav7f4lr4evqry4vka6j7kghhmwi4jcnmqazuwpnyid72buy
export INPUTFILENAME=Fridgidaire_Final_001_4444HQ_800x600.mov
export OUTPUTFILENAME=Fridgidaire_Final_001_4444HQ_150x100.mov

bacalhau docker run \
    -v bafybeihjplsav7f4lr4evqry4vka6j7kghhmwi4jcnmqazuwpnyid72buy:/inputs \
    --id-only\
    linuxserver/ffmpeg \
    -- ffmpeg -i /inputs/${INPUTFILENAME} -vf scale=150:100 \
    /outputs/${OUTPUTFILENAME}

#todo fix - Not yet working

```


# Export screenshot images every 5 seconds
```
# Local test
export INPUTFILENAME=Fridgidaire_Final_001_4444HQ_800x600.mov
export OUTPUTFILESTRING=output_%04d.jpg

ffmpeg -i inputs/${INPUTFILENAME} -r 0.2 outputs/${OUTPUTFILESTRING}


# Docker test
# todo modify this to run on a Docker image

## Bacalhau command

# todo modify this to run on Bacalhau
```





# Object detection with Yolo
- Bacalhau docs example: https://docs.bacalhau.org/examples/model-inference/object-detection-yolo5/
- Github: https://github.com/ultralytics/yolov5
- Dockerhub: https://hub.docker.com/r/ultralytics/yolov5

```
export INPUTFILENAME=Fridgidaire_Final_001_4444HQ_800x600.mov

# Local test
pip install ultralytics
git clone https://github.com/ultralytics/yolov5  # clone
cd yolov5
pip install -r requirements.txt
pip install --force-reinstall -v "MySQL_python==1.2.2"
pip3 install torch
python detect.py --weights ../inputs/yolov5s-seg.pt --source ../outputs/output_0015.jpg 
# not yet working

docker run -it --rm -v  ultralytics/yolov5 /bin/bash

# todo download this file: https://github.com/ultralytics/yolov5/releases/download/v7.0/yolov5n-seg.pt

# todo: revisit the pipeline concept

# example command from docs
python segment/predict.py --weights yolov5m-seg.pt --data data/images/bus.jpg

#code: https://github.com/ultralytics/yolov5/tree/master/segment


--input-urls https://github.com/ultralytics/yolov5/releases/download/v6.2/yolov5s.pt \
ultralytics/yolov5:v6.2 \
-- /bin/bash -c 'find /inputs -type f -exec cp {} /outputs/yolov5s.pt \; ; python detect.py --weights /outputs/yolov5s.pt --source $(pwd)/data/images --project /outputs'
```




# Easy OCR
- Bacalhau example: https://docs.bacalhau.org/examples/model-inference/EasyOCR/



# Appendix

#Convert
#todo? ffmpeg -i my-video.mov -vcodec h264 -acodec mp2 my-video.mp4
#Trim
#ffmpeg -i input.mp4 -ss 00:05:20 -t 00:10:00 -c:v copy -c:a copy output1.mp4
#Probe the file's resolutions
#ffprobe <input-file>