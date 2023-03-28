# Prelinger Decentralized Video Processing Pipeline with Project Bacalhau
https://archive.org/details/prelinger
https://bacalhau.org/

# Scale with ffmpeg - Local Docker Test
```bash

export INPUTFILENAME=Fridgidaire_Final_001_4444HQ_800x600.mov
export OUTPUTFILENAME=Fridgidaire_Final_001_4444HQ_150x100.mov
mkdir -p outputs

docker run --rm -v $PWD/assets:/inputs -v $PWD/assets:/outputs\
    linuxserver/ffmpeg \
    -i /inputs/${INPUTFILENAME} -vf scale=150:100 \
    /outputs/${OUTPUTFILENAME}

# Interactive: mode docker run --rm -it -v $PWD/assets:/inputs --entrypoint /bin/bash linuxserver/ffmpeg

# Scale with ffmpeg - On Bacalhau
# inputs folder IPFS CID: bafybeihjplsav7f4lr4evqry4vka6j7kghhmwi4jcnmqazuwpnyid72buy

bacalhau docker run \
    -v bafybeihjplsav7f4lr4evqry4vka6j7kghhmwi4jcnmqazuwpnyid72buy:/inputs \
    --id-only\
    linuxserver/ffmpeg \
    -- ffmpeg -i /inputs/${INPUTFILENAME} -vf scale=150:100 \
    /outputs/${OUTPUTFILENAME}

```


# Export screenshot images every 5 seconds
```bash
# Local test
export INPUTFILENAME=Fridgidaire_Final_001_4444HQ_800x600.mov
export OUTPUTFILESTRING=output_%04d.jpg

ffmpeg -i inputs/${INPUTFILENAME} -r 0.1 outputs/${OUTPUTFILESTRING}


# Docker test
docker run --rm -v $PWD/assets:/inputs -v $PWD/assets:/outputs \
    linuxserver/ffmpeg \
    -- -i inputs/${INPUTFILENAME} -r 0.1 outputs/${OUTPUTFILESTRING}

## Bacalhau command
bacalhau docker run \
    -v bafybeihjplsav7f4lr4evqry4vka6j7kghhmwi4jcnmqazuwpnyid72buy:/inputs \
    --id-only\
    linuxserver/ffmpeg \
    -- ffmpeg -i inputs/${INPUTFILENAME} -r 0.1 outputs/${OUTPUTFILESTRING}

```





# Object detection with Yolo
- Bacalhau docs example: https://docs.bacalhau.org/examples/model-inference/object-detection-yolo5/
- Github: https://github.com/ultralytics/yolov5
- Dockerhub: https://hub.docker.com/r/ultralytics/yolov5

```bash
export INPUTFILENAME=output_0015.jpg

# Local test
pip install ultralytics
git clone https://github.com/ultralytics/yolov5  # clone
cd yolov5
opip install -r requirements.txt
pip3 install torch
python detect.py --weights ../inputs/yolov5s-seg.pt --source ../outputs/${INPUTFILENAME} 
# not yet working

#docker run -it --rm -v  ultralytics/yolov5 /bin/bash

docker run --rm -v $PWD/assets:/inputs -v $PWD/assets:/usr/src/app/outputs \
    ultralytics/yolov5 \
    python detect.py --weights /inputs/yolov5s-seg.pt --source /outputs/${INPUTFILENAME}

docker run --rm -it -v $PWD/assets:/inputs -v $PWD/assets:/usr/src/app/outputs \
    ultralytics/yolov5 /bin/bash



# example command from docs
python segment/predict.py --weights yolov5m-seg.pt --data data/images/bus.jpg

#code: https://github.com/ultralytics/yolov5/tree/master/segment


--input-urls https://github.com/ultralytics/yolov5/releases/download/v6.2/yolov5s.pt \
ultralytics/yolov5:v6.2 \
-- /bin/bash -c 'find /inputs -type f -exec cp {} /outputs/yolov5s.pt \; ; python detect.py --weights /outputs/yolov5s.pt --source $(pwd)/data/images --project /outputs'
```




# Easy OCR
- Bacalhau example: https://docs.bacalhau.org/examples/model-inference/EasyOCR/

```bash

```

# todo: revisit the pipeline concept


# Appendix

#Convert
#todo? ffmpeg -i my-video.mov -vcodec h264 -acodec mp2 my-video.mp4
#Trim
#ffmpeg -i input.mp4 -ss 00:05:20 -t 00:10:00 -c:v copy -c:a copy output1.mp4
#Probe the file's resolutions
#ffprobe <input-file>