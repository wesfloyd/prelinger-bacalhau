# Prelinger Decentralized Video Processing Pipeline with Project Bacalhau
- https://archive.org/details/prelinger
- https://bacalhau.org/

# Scale video resolution with ffmpeg
```bash

export INPUTFILENAME=Fridgidaire_Final_001_4444HQ_800x600.mov
export OUTPUTFILENAME=Fridgidaire_Final_001_4444HQ_150x100.mov

#Local Docker test on Mac
docker run --rm -v $PWD/assets/videos:/inputs -v $PWD/assets/videos:/outputs\
    linuxserver/ffmpeg \
    -i /inputs/${INPUTFILENAME} -vf scale=150:100 \
    /outputs/${OUTPUTFILENAME}


# Bacalhau test
# inputs folder IPFS CID for Fridgidaire_Final_001_4444HQ_800x600.mov: bafybeihjplsav7f4lr4evqry4vka6j7kghhmwi4jcnmqazuwpnyid72buy
# https://api.estuary.tech/gw/ipfs/bafybeihjplsav7f4lr4evqry4vka6j7kghhmwi4jcnmqazuwpnyid72buy
bacalhau docker run \
    -v bafybeihjplsav7f4lr4evqry4vka6j7kghhmwi4jcnmqazuwpnyid72buy:/inputs \
    --id-only\
    linuxserver/ffmpeg \
    -- ffmpeg -i /inputs/${INPUTFILENAME} -vf scale=150:100 \
    /outputs/${OUTPUTFILENAME}

```


# Export screenshot images (frames) with ffmpeg
```bash
# Local Test
export INPUTFILENAME=Fridgidaire_Final_001_4444HQ_800x600.mov
export OUTPUTFILESTRING=Frigidaire_%04d.jpg

ffmpeg -i assets/videos/${INPUTFILENAME} -r 0.05 assets/frames/${OUTPUTFILESTRING}

export INPUTFILENAME=Japanese1943.mp4
export OUTPUTFILESTRING=Japanese1943_%04d.jpg

ffmpeg -i assets/videos/${INPUTFILENAME} -r 0.025 assets/frames/${OUTPUTFILESTRING}


# Docker test
export INPUTFILENAME=Fridgidaire_Final_001_4444HQ_800x600.mov
export OUTPUTFILESTRING=Frigidaire_%04d.jpg
docker run --rm -v $PWD/assets/videos:/inputs -v $PWD/assets/frames:/outputs \
    linuxserver/ffmpeg \
    -i inputs/${INPUTFILENAME} -r 0.05 /outputs/${OUTPUTFILESTRING}

## Bacalhau command
# inputs folder IPFS CID for Fridgidaire_Final_001_4444HQ_800x600.mov: bafybeihjplsav7f4lr4evqry4vka6j7kghhmwi4jcnmqazuwpnyid72buy
bacalhau docker run \
    -v bafybeihjplsav7f4lr4evqry4vka6j7kghhmwi4jcnmqazuwpnyid72buy:/inputs \
    --id-only\
    linuxserver/ffmpeg \
    -- ffmpeg -i inputs/${INPUTFILENAME} -r 0.1 outputs/${OUTPUTFILESTRING}

```


# Object detection with yolov8
```bash
# Local Test Setup
pip install ultralytics

# Local Test on mac
export INPUTFILENAME=output_0015.jpg
yolo detect predict model=$PWD/assets/yolov8n.pt save=true source="${PWD}/assets/frames"

# Docker-Mac Test
#Note the /predict folder is incremented via detect.py so the output folder path needs to be managed creatively
export INPUTFILENAME=Frigidaire_0004.jpg
docker run --rm -v $PWD/assets:/assets \
    -v $PWD/assets/predictions:/predict \
    ultralytics/ultralytics:latest-arm64 \
    yolo detect predict save=true source="/assets/frames/${INPUTFILENAME}" && \
    cp /usr/src/ultralytics/runs/detect/predict/* /predict

# Bacalhau Test
export INPUTCID=bafkreidbrvycmzaqdguf2s4icej73rguvwqgfcjokghey3ppexjxbuvplm

bacalhau docker run \
    -v bafybeihjplsav7f4lr4evqry4vka6j7kghhmwi4jcnmqazuwpnyid72buy:/assets/${INPUTFILENAME} \
    -o predictions:/predict \
    --id-only --network=full \
    ultralytics/ultralytics \
    -- yolo detect predict save=true source="/assets/${INPUTFILENAME}" && cp /usr/src/ultralytics/runs/detect/predict/* /predict
    #todo get this working

```




# OCR with tesseract
```bash

#Install on Mac
brew install tesseract
# CLI docs https://tesseract-ocr.github.io/tessdoc/Command-Line-Usage.html

#Local test
export INPUTFILENAME=Japanese1943_0003.jpg
tesseract $PWD/assets/frames/${INPUTFILENAME} ${INPUTFILENAME}_ocr

#Docker test 
docker run --rm -v $PWD/assets/frames/${INPUTFILENAME}:/app -w /app clearlinux/tesseract-ocr tesseract xxx.tiff stdout --oem 1
#todo working here

#Bacalhau test
export INPUTCID=bafkreihaumtvwjxqb4dhxdrf44mte5jj6b6zs6hngji63mzxjv27ek6zn4



```



# Appendix
