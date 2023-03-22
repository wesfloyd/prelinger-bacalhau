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
sudo apt install python-pip
pip install gdown -y

#40GB frigidaire video
gdown https://drive.google.com/uc?id=17qdQ56Q8qecJo5AtvJtsGxtTvu71qdwn
gsutil cp *.txt gs://my-bucket

#wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=1pUOOBK5NPh9OkVyP8ZxBNQRwuRMJ46yz' -O frigidaire.mov

#290GB frigidaire video
gdown https://drive.google.com/uc?id=1RudFMwYVuP9Nd8-StqXE81Gl_u2v9au7

#Probe the file's resolutions
ffprobe -v error -select_streams v:0 -show_entries stream=width,height -of csv=s=x:p=0 input.mp4

ffmpeg -i input.mp4 -vf scale=$w:$h <encoding-parameters> output.mp4


#https://ottverse.com/change-resolution-resize-scale-video-using-ffmpeg/
#https://ffmpeg.org/ffmpeg.html
#ffmpeg -i movie.mov -c:v libx264 -c:a copy -crf 20 newmovie.mov