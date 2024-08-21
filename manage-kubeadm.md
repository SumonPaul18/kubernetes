### How do I find the join command for kubeadm on the master?

    kubeadm token create --print-join-command

Here is a bash script that automate this task

    read -p 'master ip address : ' ipaddr
    sha_token = "$(openssl x509 -pubkey -in /etc/kubernetes/pki/ca.crt | openssl rsa -pubin -outform der 2>/dev/null | openssl dgst -sha256 -hex | sed 's/^.* //')"
    token = "$(kubeadm token list | awk '{print $1}' | sed -n '2 p')"
    echo "kubeadm join $ipaddr:6443 --token=$token --discovery-token-ca-cert-hash sha256:$sha_token"

#
Continuously watching kubernetes all services

    watch kubectl get all -o wide

List of Kubernetes Nodes:

    kubectl get nodes
View cluster events
    kubectl get events

View the kubectl configuration
    kubectl config view

Accessing Kubernetes Dashboard

Installing the Kubernetes Dashboard

    kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.7.0/aio/deploy/recommended.yaml 

List of Namespaces

    kubectl get services --all-namespaces

Check all the resources

    kubectl get all -n kubernetes-dashboard

Accessing the Kubernetes Dashboard from Outside

Easy Ways

Port Forwarding for kubernetes-dashboard

    kubectl port-forward -n kubernetes-dashboard service/kubernetes-dashboard 10443:443 --address 0.0.0.0

https://192.168.0.89:10443

Another Ways

We will have to change the type of service from ClusterIp to NodePort. So, give the following command to edit the service and make the following changes.

    kubectl edit service/kubernetes-dashboard -n kubernetes-dashboard

After: You can give the IP of your wish if 32321 is occupied

Now, check if the service was changed successfully by giving the following command:

    kubectl get svc

It will open the Kubernetes dashboard in the web browser.

> kubectl proxy --address='0.0.0.0' --disable-filter=true <br>
> kubectl proxy --address='0.0.0.0' --accept-hosts='^*$' <br>
> kubectl proxy --address='0.0.0.0' --port=8001 --accept-hosts='^*$' <br>

    kubectl -n kubernetes-dashboard describe service kubernetes-dashboard

#
