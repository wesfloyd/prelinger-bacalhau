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

gcloud compute instances start instance-1 --zone "northamerica-northeast1-a"
gcloud compute ssh --zone "northamerica-northeast1-a" "instance-1"  --project "bacalhau-355518"
gcloud compute instances stop instance-1 --zone "northamerica-northeast1-a"

sudo apt update
sudo apt install ca-certificates curl gnupg python-pip ffmpeg docker -y
pip install gdown

curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh ./get-docker.sh
sudo groupadd docker
sudo usermod -aG docker ${USER}


#40GB frigidaire video
gdown https://drive.google.com/uc?id=17qdQ56Q8qecJo5AtvJtsGxtTvu71qdwn
gsutil cp Fridgidaire_Final_001_4444HQ_4096x3072.mov gs://prelinger
#wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=1pUOOBK5NPh9OkVyP8ZxBNQRwuRMJ46yz' -O frigidaire.mov

#290GB frigidaire video
gdown https://drive.google.com/uc?id=1TyR5nFLnVEp7XHZfaUKWFAE4ZzwNakZi
#todo get this working

gcloud compute scp instance-1:/home/wes/prelinger-bacalhau/assets/prelinger2/*  ./ --zone=northamerica-northeast1-a

