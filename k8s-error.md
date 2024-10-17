#
## Kubernetes Error-Troubleshooting-Solutions
#
#### What Is Kubernetes ImagePullBackOff? 
The ImagePullBackOff error is a common error message in Kubernetes that occurs when a container running in a pod fails to pull the required image from a container registry. This error can occur for a variety of reasons, including network connectivity issues, incorrect image name or tag, missing credentials, or insufficient permissions.

When a pod is created, Kubernetes attempts to pull the container image specified in the pod definition from the container registry. If the image is not available or cannot be pulled, Kubernetes marks the pod as “ImagePullBackOff” and stops attempting to pull the image. Thus, the pod will not be able to start and will remain in a pending state.

#
#### Clear Kubernetes Cache
#
## under events: issue — Warning FailedCreatePodSandBox 12s kubelet Failed to create pod sandbox: rpc error: code = Unknown desc = failed to setup network for sandbox “7bcf49a342eec250898e07e32a4f651056d3600a58beb056bf828b7e8640082c”: plugin type=”flannel” failed (add): loadFlannelSubnetEnv failed: open : no such file or directory

#### Solution:
Solution: Create file /run/flannel/subnet.env on master node:
```
nano /run/flannel/subnet.env
```
enter below:
```
FLANNEL_NETWORK=10.244.0.0/16
FLANNEL_SUBNET=10.244.0.1/24
FLANNEL_MTU=1450
FLANNEL_IPMASQ=true
```
```
systemctl stop kubelet
```
```
systemctl stop docker
```
```
iptables --flush
```
```
iptables -tnat --flush
```
```
systemctl start kubelet
```
```
systemctl start docker
```
This is the complete solution.
#
