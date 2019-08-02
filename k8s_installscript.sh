
#!/bin/sh
# Add the Cloud SDK distribution URI as a package source
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

# Import the Google Cloud Platform public key
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -

# Update the package list and install the Cloud SDK
sudo apt-get update && sudo apt-get install -y google-cloud-sdk

##Set the project id:
gcloud config set project blade-ai
gcloud auth activate-service-account --key-file blade-ai-4e9b781e83fb.json 

gcloud config list

# GKE cluster:
export my_zone=us-central1-a
export my_cluster=standard-cluster-1
gcloud container clusters create $my_cluster --num-nodes 3 --zone $my_zone --enable-ip-alias


#Connect to a GKE cluster:
gcloud container clusters get-credentials $my_cluster --zone $my_zone

source <(kubectl completion bash)

echo "k8s cluster created"

