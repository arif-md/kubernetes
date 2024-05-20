# make sure terraform CLI is installed
terraform

# format the tf files
terraform fmt

# initialize terraform Azure modules
terraform init

# validate the template
terraform validate

# plan and save the infra changes into tfplan file
terraform plan -out tfplan

# show the tfplan file
terraform show -json tfplan
terraform show -json tfplan >> tfplan.json

# Format tfplan.json file
terraform show -json tfplan | jq '.' > tfplan.json

# show only the changes
cat tfplan.json | jq -r '(.resource_changes[] | [.change.actions[], .type, .change.after.name]) | @tsv'
cat tfplan.json | jq '[.resource_changes[] | {type: .type, name: .change.after.name, actions: .change.actions[]}]' 

# apply the infra changes
terraform apply tfplan

# Move the received credentials to kubectl home dir so that we can connect to cluster.
# First take the backup of existing file.
mv ~/.kube/config/kubeconfig ~/.kube/config/kubeconfig_<date>
mv kubeconfig ~/.kube/config

# debugging
kubectl get nodes
kubectl debug node/<node name from above command output> -it --image=<image name of the node, example ubuntu>

# Test Jenkins installation
# Copy the public IP address of the jenkins server printed in the console, if not found execute the command
ssh devops@public_ip
sudo service jenkins status (Wait for couple of mins until jenkins get installed)
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
#Check the logs at : /var/log/cloud-init.log
http://public_ip:8080

# delete the infra
terraform destroy --auto-approve

# cleanup files
rm terraform.tfstate
rm terraform.tfstate.backup
rm tfplan
rm tfplan.json
rm -r .terraform/