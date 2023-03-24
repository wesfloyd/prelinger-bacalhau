#/bin/bash

gcloud compute instances create instance-1 \
    --project=bacalhau-355518 \
    --zone=northamerica-northeast1-a \
    --machine-type=c2-standard-8 \
    --network-interface=network-tier=PREMIUM,subnet=default \
    --maintenance-policy=MIGRATE \
    --provisioning-model=STANDARD \
    --service-account=942328987507-compute@developer.gserviceaccount.com \
    --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append \
    --create-disk=auto-delete=yes,boot=yes,device-name=instance-1,image=projects/ubuntu-os-cloud/global/images/ubuntu-1804-bionic-v20230308,mode=rw,size=400,type=projects/bacalhau-355518/zones/us-central1-a/diskTypes/pd-balanced \
    --no-shielded-secure-boot \
    --shielded-vtpm \
    --shielded-integrity-monitoring \
    --labels=ec-src=vm_add-gcloud \
    --reservation-affinity=any

gcloud compute ssh --zone "northamerica-northeast1-a" "instance-1"  --project "bacalhau-355518"

sudo apt update
sudo apt install python-pip ffmpeg ffprobe -y
pip install gdown

#40GB frigidaire video
gdown https://drive.google.com/uc?id=17qdQ56Q8qecJo5AtvJtsGxtTvu71qdwn
gsutil cp Fridgidaire_Final_001_4444HQ_4096x3072.mov gs://prelinger
#wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=1pUOOBK5NPh9OkVyP8ZxBNQRwuRMJ46yz' -O frigidaire.mov

#290GB frigidaire video
gdown https://drive.google.com/uc?id=1ygfi8CvcOXKZRkllOf4VXQoVthxKIf4X


ffmpeg -i Fridgidaire_Final_001_4444HQ_4096x3072.mov -vf scale=1400:1050  Fridgidaire_Final_001_4444HQ_1400x1050.mov 
gcloud compute scp instance-1:/home/wes/Fridgidaire_Final_001_4444HQ_1400x1050.mov  ./Fridgidaire_Final_001_4444HQ_1400x1050.mov



#Convert
#ffmpeg -i my-video.mov -vcodec h264 -acodec mp2 my-video.mp4
#ffmpeg -i Fridgidaire_Final_001_4444HQ_4096x3072.mov -vcodec h264 -acodec mp2 Fridgidaire_Final_001_4444HQ.mp4
#Trim
#ffmpeg -i input.mp4 -ss 00:05:20 -t 00:10:00 -c:v copy -c:a copy output1.mp4
#Probe the file's resolutions
#ffprobe <input-file>