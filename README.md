# 📦 Kubernetes Guide - Complete Beginner to Advanced

<div align="center">
	<img width = "33%" src="https://github.com/SumonPaul18/kubernetes/blob/main/images/Kubernetes.png?raw=true">
</div>

Welcome to the **Kubernetes** repository! This is your one-stop destination to learn Kubernetes from scratch to advanced level with **detailed theory, practical examples**, and **real-world use cases**.

---

## 📚 Table of Contents

### 🧠 Introduction
- [What is Kubernetes](#1--introduction-to-kubernetes)
- [Pros & Cons of Kubernetes](#2-%EF%B8%8F-pros--cons-of-kubernetes-with-practical-examples)
- [Kubernetes Architecture](#%EF%B8%8F-kubernetes-architecture--explained-with-real-life-examples)
- [Key Components](#-4-key-components-updated-with-clarity)

### ⚙️ Installation & Setup
- [Install Kubernetes on Local Machine (Minikube)](#install-kubernetes-on-local-machine)
- [Install Kubernetes on Cloud (GKE, EKS, AKS)](#install-kubernetes-on-cloud)
- [Kubernetes Cluster Setup using kubeadm](#kubernetes-cluster-setup-using-kubeadm)
- [Using kubectl - Kubernetes CLI Tool](#using-kubectl)

### 📦 Core Concepts
- [Pods, ReplicaSets, Deployments](#pods-replicasets-deployments)
- [Services & Networking](#services--networking)
- [Volumes & Persistent Storage](#volumes--persistent-storage)
- [ConfigMaps & Secrets](#configmaps--secrets)
- [Namespaces](#namespaces)
- [Helm - Kubernetes Package Manager](#helm)

### 🛠️ Practical Examples
- [Deploy a Nginx Web Server](#deploy-a-nginx-web-server)
- [Rolling Updates & Rollbacks](#rolling-updates--rollbacks)
- [Scaling Applications](#scaling-applications)
- [Persistent Volume with MySQL](#persistent-volume-with-mysql)
- [Ingress Controller Example](#ingress-controller-example)

### 🔐 Security & RBAC
- [Role-Based Access Control (RBAC)](#rbac)
- [Network Policies](#network-policies)
- [TLS & Secrets Management](#tls--secrets-management)

### 📈 Monitoring & Logging
- [Metrics Server](#metrics-server)
- [Prometheus & Grafana Setup](#prometheus--grafana-setup)
- [Logging with EFK Stack](#logging-with-efk-stack)

### ⚙️ CI/CD Integration
- [Kubernetes + Jenkins Pipeline](#kubernetes--jenkins)
- [Kubernetes + GitHub Actions](#kubernetes--github-actions)

### ☸️ Advanced Kubernetes
- [Custom Resource Definitions (CRDs)](#crds)
- [Operators in Kubernetes](#operators)
- [Pod Affinity & Tolerations](#affinity--tolerations)
- [Horizontal & Vertical Pod Autoscaling](#autoscaling)
- [Kubernetes Backup & Disaster Recovery](#backup--dr)

### 🧪 Real-world Projects
- [Multi-tier App Deployment (Frontend + Backend + DB)](#multi-tier-app-deployment)
- [Monitoring & Alerting Dashboard](#monitoring--alerting)
- [Production Ready Kubernetes Cluster](#production-ready-cluster)

### 🌍 Resources
- [Kubernetes Official Docs](https://kubernetes.io/docs/)
- [Kubernetes GitHub](https://github.com/kubernetes/kubernetes)
- [Kubernetes Tutorials & Blogs](#tutorials--blogs)

---

### 1. 📘 Introduction to Kubernetes
Kubernetes, also known as K8s, is an open-source system for automating the deployment, scaling, and management of containerized applications. It groups containers that make up an application into logical units for easy management and discovery.

Here’s a clear and practical breakdown of **Kubernetes Pros & Cons** with **real-life examples** to help you truly understand both the power and complexity of Kubernetes in production:

---

### 2. ⚖️ Pros & Cons of Kubernetes (with Practical Examples)

#### ✅ Pros (Advantages)

| Benefit | Explanation | Real-Life Example |
|--------|-------------|------------------|
| **1. Auto-Scaling** | Automatically scales your app based on load (horizontal pod autoscaling). | Your online store gets a traffic spike during Eid — K8s spins up more Pods automatically. |
| **2. Self-Healing** | Failed Pods are restarted, and unresponsive nodes are avoided. | If a node running your app crashes at midnight, K8s restarts it on another healthy node. |
| **3. Portability** | Works across any cloud (AWS, GCP, Azure) or on-premises. | Develop locally on Minikube, then deploy on GKE (Google Kubernetes Engine) with same configs. |
| **4. Declarative Configuration (YAML)** | Infra as Code using YAML files — version controlled. | You can roll back to a previous app version just by updating YAML in Git and reapplying it. |
| **5. Efficient Resource Utilization** | Smart bin-packing schedules containers efficiently. | K8s uses all your VMs evenly instead of overloading one while keeping others idle. |
| **6. Rolling Updates** | Deploy new versions without downtime. | Your React frontend gets updated smoothly while users continue browsing. |
| **7. CI/CD Friendly** | Integrates with GitOps, Jenkins, ArgoCD, etc. | Automatically deploy your new feature to dev → staging → production with pipelines. |

---

#### ❌ Cons (Challenges)

| Drawback | Explanation | Real-Life Impact |
|----------|-------------|------------------|
| **1. Steep Learning Curve** | YAML, objects, networking, Helm — it’s a lot for beginners. | Devs spend weeks learning how Pods, Services, and Ingress work before first deployment. |
| **2. Complex Debugging** | More abstraction = harder to trace issues. | An app fails because of wrong `ConfigMap` value; takes hours to trace through multiple layers. |
| **3. Resource Intensive** | K8s needs a lot of CPU & RAM just to run itself. | A small startup wastes $200/month on under-utilized nodes just running the control plane. |
| **4. Security Risks** | Misconfigured RBAC or open dashboards = big security holes. | An intern exposes the Kubernetes dashboard without auth → someone deletes resources. |
| **5. Networking Headaches** | Setting up network policies, CNI plugins, and Ingress can be tricky. | Your app isn't reachable from outside because the Ingress config or DNS is wrong. |
| **6. Overkill for Simple Apps** | A small static site doesn’t need full orchestration. | Running a personal blog on Kubernetes feels like launching a rocket for a bicycle ride. |

---

## 📌 Summary

Kubernetes is **super powerful** but requires **responsible use** and **deep understanding**. If you're managing microservices, dynamic workloads, or doing multi-cloud — it's a game-changer.

But if you’re just running a static portfolio site — you probably don’t need Kubernetes.

---

Perfect! Let’s now dive into **Kubernetes Architecture** with:

- ✅ Super simple explanation  
- ✅ Real-life practical analogies  
- ✅ Visual diagrams  
- ✅ All core topics like Master & Worker Node components  

---

### 🏗️ Kubernetes Architecture — Explained with Real-Life Examples

Kubernetes follows a **Master–Worker Node architecture** to manage containers at scale.

---

#### 🖼️ Architecture Diagram

![Kubernetes Architecture Diagram](https://kubernetes.io/images/docs/kubernetes-cluster-architecture.svg)

> **Master Node = Brain 🧠**  
> **Worker Nodes = Muscles 💪**

---

### 🧠 1. Control Plane (Master Node)

This is the brain of Kubernetes — it makes all the decisions.

#### 📌 Components:

| Component | What It Does | Real-Life Analogy |
|-----------|--------------|-------------------|
| **kube-apiserver** | Front door to the cluster (REST API server) | Reception desk — all communication goes through here |
| **etcd** | Key-value database for storing cluster state | Diary or ledger — stores all decisions, secrets, configurations |
| **kube-scheduler** | Decides where to place new Pods | Matchmaker — finds the best node for each Pod |
| **kube-controller-manager** | Watches and maintains cluster state (replica, job, node health, etc) | Supervisor — ensures everything stays as declared |

#### 🧪 Example:
You apply a YAML file to deploy 3 Pods:
- `kube-apiserver` receives it
- `etcd` stores it
- `kube-scheduler` finds nodes for the Pods
- `controller-manager` ensures 3 Pods are always running

---

### 💪 2. Worker Node (Node Agents)

This is where your apps actually run. Each worker node hosts **Pods**, which are the smallest unit in K8s.

#### 📌 Components:

| Component | What It Does | Real-Life Analogy |
|-----------|--------------|-------------------|
| **kubelet** | Talks to Master, runs containers based on instructions | Manager on the floor — executes orders from HQ |
| **kube-proxy** | Manages network traffic to/from Pods | Network technician — sets up routes and forwarding |
| **Container Runtime** | Runs the containers (Docker, containerd) | The engine — actually runs your app in a box |

#### 🧪 Example:
You deploy a web app:
- Scheduler assigns it to Node-1
- `kubelet` on Node-1 launches the container
- `kube-proxy` sets up networking so it's reachable

---

### 🔄 Real-Life Flow: What Happens When You Deploy?

```bash
kubectl apply -f webapp.yaml
```

Here’s what happens behind the scenes:

1. `kubectl` sends the YAML to **kube-apiserver**
2. `etcd` stores the desired state (3 replicas of `nginx`)
3. **Scheduler** chooses which nodes to place them on
4. **Controller Manager** ensures the Pods exist
5. **kubelet** on selected nodes spins up containers
6. **kube-proxy** opens ports and routes traffic

---

### 🧰 Optional Components (But Very Useful)

| Component | Purpose |
|----------|---------|
| **Ingress Controller** | Manages external HTTP(S) access to services |
| **DNS (CoreDNS)** | Automatically assigns internal DNS to Services |
| **Dashboard / Lens** | Web UI / visual tools to manage clusters |

---

## 🎯 Practical Tips

| Use Case | K8s Benefit |
|----------|-------------|
| You want to auto-scale microservices | ✅ Use HPA (Horizontal Pod Autoscaler) |
| You need zero-downtime deployments | ✅ Use Deployments with rolling updates |
| You want to isolate dev, test, prod | ✅ Use Namespaces |
| You want secrets managed securely | ✅ Use Kubernetes Secrets |
| You want scheduled tasks (e.g., backups) | ✅ Use CronJobs |

---

### 🧩 4. Key Components (Updated with Clarity)

Kubernetes is made up of several key components. Think of these as the **building blocks** that let Kubernetes manage your containers efficiently.

### 1. **Pod** 🚢
- Smallest unit in Kubernetes. It wraps **one or more containers**.
- All containers in a Pod **share network & storage**, and run together.
- **Real-world analogy**: Like roommates sharing a house — each has their role, but they share space.
- ✅ Example: Run a Node.js app and a Redis cache in the same Pod to reduce latency.

---

### 2. **ReplicaSet** 📈
- Ensures a set number of **identical Pods** are always running.
- **Auto-heals** failed Pods.
- ✅ Example: You want 3 instances of your app. If 1 crashes, ReplicaSet spins up a new one.

---

### 3. **Deployment** 🚀
- Provides **automated updates** and management for Pods and ReplicaSets.
- Ideal for rolling updates and rollback.
- ✅ Example: You update your app image version, Deployment handles a smooth upgrade.

📝 **Sample Deployment YAML**:
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: webapp
spec:
  replicas: 3
  selector:
    matchLabels:
      app: webapp
  template:
    metadata:
      labels:
        app: webapp
    spec:
      containers:
      - name: web-container
        image: nginx:latest
```

---

### 4. **Service** 🌐
- Exposes Pods as a **network service**.
- Helps Pods communicate internally or externally.
- Types:
  - **ClusterIP** – internal access
  - **NodePort** – exposes service on Node IP
  - **LoadBalancer** – cloud provider external IP

✅ Example:
```yaml
apiVersion: v1
kind: Service
metadata:
  name: web-svc
spec:
  type: NodePort
  selector:
    app: webapp
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
      nodePort: 30001
```

---

### 5. **ConfigMap & Secret** 🔐
- **ConfigMap**: Stores non-sensitive config (like env vars).
- **Secret**: Stores sensitive data (passwords, keys).
✅ Example:
```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-config
data:
  ENV: production
```

---

### 6. **Volume, PersistentVolume & PVC** 💾
- Store data beyond Pod lifecycle.
- **PV**: Actual storage provided by admin/cloud.
- **PVC**: User's request for storage.

✅ Example:
```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: mypvc
spec:
  accessModes: [ "ReadWriteOnce" ]
  resources:
    requests:
      storage: 1Gi
```

---

### 7. **Namespace** 🗂️
- Used to **organize** resources.
- You can separate environments: `dev`, `test`, `prod`.

✅ Example: Limit resource usage per namespace.

---

### 8. **Job & CronJob** ⏰
- **Job** runs once and completes (e.g., database migration).
- **CronJob** runs on schedule (like crontab).

✅ Real-World Example:
- Backup database every night at 2AM using CronJob.

📝 **Sample CronJob**:
```yaml
apiVersion: batch/v1
kind: CronJob
metadata:
  name: nightly-backup
spec:
  schedule: "0 2 * * *"
  jobTemplate:
    spec:
      template:
        spec:
          containers:
          - name: backup
            image: alpine
            command: ["sh", "-c", "echo Backing up..."]
          restartPolicy: OnFailure
```
---

 ### 2. ⚙️ Installation & Setup
 
 #### A. Local (Minikube)
 **[Install Kubernetes using Minikube](https://github.com/SumonPaul18/kubernetes/blob/main/install-minikube.md)**
 
 #### B. Multi-node Cluster (kubeadm)
 **[Install Kubernetes using KubeAdm](https://github.com/SumonPaul18/kubernetes/tree/main/install-kubeadm)**
 
 #### C. Cloud Providers
 
 - **GKE**: Google Kubernetes Engine
 - **EKS**: AWS
 - **AKS**: Azure Kubernetes Service
 - 
---

### 3. 🧰 Using `kubectl` – The Kubernetes Command-Line Tool

#### 🚀 What is `kubectl`?

`kubectl` is the **command-line interface for interacting with your Kubernetes cluster**. It lets you create, inspect, update, delete, and manage resources.

> Think of `kubectl` as your **remote control** to manage Kubernetes from your terminal.

---
# 🧠 kubectl Command Reference - Grouped & Role-Based

---

## 📁 1. Basic Cluster & Configuration Commands

| Command | Description |
|--------|-------------|
| `kubectl version` | Show client & server version |
| `kubectl config view` | View kubeconfig details |
| `kubectl config get-contexts` | Show all available contexts |
| `kubectl config use-context <name>` | Switch to a specific context |
| `kubectl cluster-info` | Show cluster master and services |
| `kubectl get componentstatuses` | Health of control plane components |
| `kubectl api-resources` | List all resource types |
| `kubectl api-versions` | List supported API versions |
| `kubectl help` | Show help message |

---

## 📦 2. Resource Management Commands

### 🔎 View Resources

```bash
kubectl get [resource]
kubectl get pods
kubectl get svc
kubectl get all
kubectl get nodes
kubectl get events
```

### 📋 Describe / Inspect

```bash
kubectl describe [resource] <name>
kubectl describe pod mypod
```

### 📂 Output Formats

```bash
kubectl get pod -o wide
kubectl get svc -o yaml
kubectl get deployment -o json
```

---

## 🧱 3. Create, Update, Delete Resources

### 📌 Create

```bash
kubectl create deployment nginx --image=nginx
kubectl create namespace dev
kubectl create configmap my-config --from-literal=env=dev
kubectl create secret generic my-secret --from-literal=password=12345
```

### ⚙️ Apply / Update

```bash
kubectl apply -f deployment.yaml
kubectl apply -k ./kustomization-dir
```

### 🧹 Delete

```bash
kubectl delete pod mypod
kubectl delete svc myservice
kubectl delete -f deployment.yaml
kubectl delete namespace dev
```

---

## ⚙️ 4. Pod Management Commands

| Use | Command |
|-----|---------|
| Exec inside container | `kubectl exec -it <pod> -- /bin/bash` |
| View logs | `kubectl logs <pod>` |
| Stream logs | `kubectl logs -f <pod>` |
| Logs for a container | `kubectl logs <pod> -c <container-name>` |
| Port forwarding | `kubectl port-forward pod/mypod 8080:80` |
| Copy files | `kubectl cp mypod:/app/file.txt ./file.txt` |
| Restart Pod | Delete it – it’ll auto-restart from ReplicaSet: <br> `kubectl delete pod <pod>` |

---

## 📋 5. Deployment & Rollouts

```bash
kubectl rollout status deployment my-deploy
kubectl rollout history deployment my-deploy
kubectl rollout undo deployment my-deploy
kubectl set image deployment/my-deploy nginx=nginx:latest
```

---

## 🚨 6. Debugging & Troubleshooting

```bash
kubectl describe pod <pod>
kubectl get events --sort-by=.metadata.creationTimestamp
kubectl top pod
kubectl top node
kubectl get pod -o wide
kubectl exec <pod> -- env
kubectl exec <pod> -- cat /etc/config/settings.yaml
```

---

## 🧪 7. Testing & Dry Runs

```bash
kubectl apply -f myapp.yaml --dry-run=client -o yaml
kubectl create deployment nginx --image=nginx --dry-run=client -o yaml
```

---

## 🌐 8. Services, Ingress & Networking

```bash
kubectl expose deployment nginx --port=80 --type=NodePort
kubectl get svc
kubectl describe svc nginx
kubectl port-forward service/myservice 8080:80
```

---

## 📊 9. Metrics & Monitoring

```bash
kubectl top nodes
kubectl top pods
```

🔔 Requires metrics-server installed

---

## 🗃️ 10. Namespaces

```bash
kubectl get namespaces
kubectl create namespace test
kubectl delete namespace test
kubectl get pods --namespace=test
kubectl config set-context --current --namespace=test
```

---

## 🛠️ 11. Resource Patching

```bash
kubectl patch deployment nginx -p '{"spec":{"replicas":5}}'
```

---

## 🧵 12. Jobs & CronJobs

```bash
kubectl create job myjob --image=busybox -- /bin/sh -c 'echo Hello!'
kubectl get jobs
kubectl delete job myjob

kubectl create cronjob mycron --image=busybox --schedule="*/1 * * * *" -- /bin/sh -c 'echo Running Cron'
kubectl get cronjobs
```

---

## 🧪 13. Custom Resources & CRDs

```bash
kubectl get crds
kubectl describe crd <name>
kubectl get <custom-resource>
```

---

## 👩‍💻 14. RBAC & Security

```bash
kubectl create serviceaccount viewer
kubectl create role pod-reader --verb=get,list,watch --resource=pods
kubectl create rolebinding viewer-binding --role=pod-reader --serviceaccount=default:viewer
kubectl auth can-i create deployments
```

---

## 🔄 15. Useful Shortcuts

```bash
# Shorthand
kubectl get po             # pods
kubectl get svc            # services
kubectl get deploy         # deployments
kubectl get ns             # namespaces
kubectl get rs             # replicasets

# Alias (recommended)
alias k='kubectl'
k get pods
```
---

## 🧰 16. Labeling, Annotating & Tainting

### 📌 Labeling Resources

```bash
kubectl label pod mypod app=nginx
kubectl get pods --show-labels
kubectl get pods -l app=nginx
```

### 📝 Annotations

```bash
kubectl annotate pod mypod description='This is a test pod'
kubectl describe pod mypod | grep -i annotations
```

### ☣️ Node Taints & Tolerations

```bash
kubectl taint nodes node1 key=value:NoSchedule
kubectl describe node node1 | grep -i taint
```

> 🧠 Useful for advanced scheduling and resource management!

---

## 📅 17. Autoscaling & Resource Quotas

### 📈 Autoscaling Deployment

```bash
kubectl autoscale deployment nginx --cpu-percent=50 --min=1 --max=5
kubectl get hpa
```

### 🧮 Resource Quotas

```bash
kubectl create quota dev-quota --hard=pods=10,cpu=4,memory=8Gi --namespace=dev
```

---

## 📦 18. Export & Backup

### Export resources to YAML/JSON

```bash
kubectl get deployment myapp -o yaml > myapp.yaml
kubectl get all --all-namespaces -o yaml > full-backup.yaml
```

---

## 🚀 19. Running Imperative Commands

Useful when you don’t want to write YAML:

```bash
kubectl run nginx --image=nginx --port=80
kubectl expose pod nginx --port=80 --target-port=80 --type=NodePort
```

---

## 🧹 20. Clean Up Resources Fast

```bash
kubectl delete all --all
kubectl delete pods --all -n dev
kubectl delete pvc --all
```

---

## 🔐 21. Authentication & Authorization Debugging

```bash
kubectl auth can-i list pods --as=dev-user
kubectl auth reconcile -f rbac.yaml
```

---

## 📤 22. Kustomize (Built-in!)

```bash
kubectl kustomize ./overlays/prod/
kubectl apply -k ./overlays/prod/
```

---

## 🧪 23. Testing with Ephemeral Containers (K8s 1.23+)

```bash
kubectl debug pod/mypod --image=busybox --target=mycontainer
```

---

## 🧭 24. Plugins & Extensions

```bash
kubectl krew install ctx
kubectl krew install ns
kubectl ctx       # switch context
kubectl ns        # switch namespace
```

> ✨ `krew` = plugin manager for `kubectl` — opens up tons of community plugins

---

### 👥 Role-Based Views

Kubernetes users typically fall into different roles. Each role interacts with `kubectl` differently, focusing on specific operations. Below is a structured breakdown:

---

### ➤ 👨‍💻 Developers

#### 🛠️ Primary Focus:
- Writing code
- Debugging pods
- Managing application deployments
- Accessing logs and port forwarding for local testing

#### 🧪 Common Commands:

```bash
kubectl get pods
kubectl get services
kubectl describe pod mypod
kubectl logs mypod
kubectl exec -it mypod -- /bin/bash
kubectl apply -f deployment.yaml
kubectl delete -f service.yaml
kubectl port-forward pod/mypod 8080:80
```

#### ✅ Use Cases:
- Check if pods are running properly.
- View logs of a crashed app: `kubectl logs mypod --previous`
- Exec into container: `kubectl exec -it mypod -- bash`
- Apply new deployments: `kubectl apply -f app-deploy.yaml`

#### 🔒 Required RBAC Permissions:
```yaml
rules:
- apiGroups: [""]
  resources: ["pods", "services", "pods/log", "pods/exec"]
  verbs: ["get", "list", "watch", "create", "delete", "update"]
```

---

### ➤ 🔧 DevOps / SRE (Site Reliability Engineers)

#### 🛠️ Primary Focus:
- Application stability, performance, scaling
- Monitoring rollout strategies
- Managing jobs, cronjobs, autoscaling
- Debugging node-level issues

#### 🧪 Common Commands:

```bash
kubectl rollout status deployment/myapp
kubectl top pod
kubectl patch deployment myapp --patch '{"spec":{"replicas":5}}'
kubectl autoscale deployment myapp --cpu-percent=50 --min=2 --max=6
kubectl get events --sort-by='.metadata.creationTimestamp'
kubectl get job
kubectl get cronjob
```

#### ✅ Use Cases:
- Scale deployments during peak hours
- Monitor resource usage: `kubectl top node`
- Observe restart crashes in Pods
- Run batch jobs with `kubectl create -f backup-job.yaml`

#### 🔒 Required RBAC Permissions:
```yaml
rules:
- apiGroups: ["apps", "batch"]
  resources: ["deployments", "replicasets", "jobs", "cronjobs"]
  verbs: ["get", "list", "create", "update", "delete"]
- apiGroups: ["metrics.k8s.io"]
  resources: ["pods", "nodes"]
  verbs: ["get", "list"]
```

---

### ➤ 🛡️ Cluster Admin

#### 🛠️ Primary Focus:
- Full control over the cluster
- Security, RBAC, CRDs, namespace management
- Certificate and authentication management
- Diagnosing cluster-level issues

#### 🧪 Common Commands:

```bash
kubectl config get-contexts
kubectl config use-context mycluster
kubectl create namespace dev
kubectl get componentstatuses
kubectl get clusterrolebindings
kubectl auth can-i create deployments --as=dev-user
kubectl get crds
kubectl certificate approve <name>
kubectl taint nodes node1 key=value:NoSchedule
```

#### ✅ Use Cases:
- Approve CSR requests for TLS
- Control user access using RBAC rules
- Create or delete namespaces
- Set node-level taints for scheduling constraints
- Validate user permissions

#### 🔒 Required RBAC Permissions:
```yaml
rules:
- apiGroups: ["", "rbac.authorization.k8s.io", "certificates.k8s.io", "apiextensions.k8s.io"]
  resources: ["*"]
  verbs: ["*"]
```

---

## 🧾 Bonus: Tips for Role Separation

| Role | Recommended Namespace Scope | Automation Scope |
|------|------------------------------|------------------|
| Developer | `dev`, `test`, `feature-*` | GitHub Actions, Helm |
| DevOps / SRE | `dev`, `staging`, `prod` | CI/CD, Monitoring |
| Admin | All namespaces | RBAC, Cluster Setup |

---

## Usage Guide
### Deploying an Application

### Using ConfigMaps
How to use ConfigMaps to manage configuration data.

### Using Secrets
How to use Secrets to manage sensitive data.

## Advanced Topics
### Networking
In-depth information on Kubernetes networking.

### Storage
Guide on managing storage in Kubernetes.

### Security
Best practices for securing your Kubernetes cluster.

## 🚀 Contribution

Contributions are welcome! If you have tutorials, scripts, or tips to share, feel free to open a pull request.

## 📜 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---
Feel free to explore the documentation and contribute to make it even better!

---
