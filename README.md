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
- [Install Kubernetes on Local Machine (Minikube)](#2-%EF%B8%8F-installation--setup)
- [Kubernetes Cluster Setup using kubeadm](#2-%EF%B8%8F-installation--setup)
- [Install Kubernetes on Cloud (GKE, EKS, AKS)](#2-%EF%B8%8F-installation--setup)
- [Using kubectl - Kubernetes CLI Tool](#3--using-kubectl--the-kubernetes-command-line-tool)

### 📦 Core Concepts
- [Pods, ReplicaSets, Deployments](#3._📦_Core_Concepts_in_Kubernetes)
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

### 📌 Summary

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

### 🎯 Practical Tips

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

### 🧱 3. Create, Update, Delete Resources

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
### 3. 📦 Core Concepts in Kubernetes

---

### 🔹 1. **Pods**

**What is a Pod?**
- The smallest deployable unit in Kubernetes.
- A Pod wraps one or more containers that share the same network and storage.

**Think of it like:**  
A Pod is like a room with several machines (containers) that talk over the same internal network (localhost) and share tools (volumes).

**Use Case:**
- Running a web server and a log collector together.

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: mypod
spec:
  containers:
  - name: app
    image: nginx
  - name: sidecar
    image: busybox
    command: ["sleep", "3600"]
```

---

### 🔹 2. **ReplicaSets**

**Purpose:**
- Ensures a specified number of identical Pods are running.
- Replaces crashed pods automatically.

**Think of it like:**  
A backup generator system – if one fails, another is automatically spun up.

```yaml
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: myapp-rs
spec:
  replicas: 3
  selector:
    matchLabels:
      app: myapp
  template:
    metadata:
      labels:
        app: myapp
    spec:
      containers:
      - name: nginx
        image: nginx
```

---

### 🔹 3. **Deployments**

**Purpose:**
- Manages ReplicaSets and allows updates, rollbacks.
- Preferred way to run applications.

**Real-life Use Case:**
- Rollout version 2.0 of your app without downtime.

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: myapp-deploy
spec:
  replicas: 2
  selector:
    matchLabels:
      app: myapp
  template:
    metadata:
      labels:
        app: myapp
    spec:
      containers:
      - name: myapp
        image: nginx:1.25
```

---

### 🔹 4. **Services & Networking**

**Why Services?**
- Pods have dynamic IPs – they can change.
- Services provide a stable IP and DNS name to access a group of Pods.

**Types:**
- `ClusterIP`: Internal access only.
- `NodePort`: Exposes service on each Node IP.
- `LoadBalancer`: Exposes externally via cloud provider.

```yaml
apiVersion: v1
kind: Service
metadata:
  name: myservice
spec:
  selector:
    app: myapp
  ports:
  - port: 80
    targetPort: 80
  type: NodePort
```

---

### 🔹 5. **Volumes & Persistent Storage**

**Problem:**  
Containers are ephemeral – data is lost when they stop.

**Solution:**  
Volumes and PersistentVolumes store data outside containers.

**Use Case:**
- Database storage, file uploads.

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: mypvc
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
```

Then attach it to a Pod:
```yaml
volumes:
- name: myvol
  persistentVolumeClaim:
    claimName: mypvc
```

---

### 🔹 6. **ConfigMaps & Secrets**

**Use Case:**
- Store config values (non-sensitive) in ConfigMaps.
- Store passwords, API keys in Secrets (base64 encoded).

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-config
data:
  APP_MODE: "production"
```

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: app-secret
type: Opaque
data:
  DB_PASSWORD: cGFzc3dvcmQ=
```

Inject into Pod:
```yaml
env:
- name: DB_PASSWORD
  valueFrom:
    secretKeyRef:
      name: app-secret
      key: DB_PASSWORD
```

---

### 🔹 7. **Namespaces**

**Why?**
- Helps isolate environments (dev, test, prod) in the same cluster.

**Example:**
- Deploy dev apps in `dev` namespace:
```bash
kubectl create namespace dev
kubectl apply -f app.yaml -n dev
```

---

### 🔹 8. **Helm - Kubernetes Package Manager**

**What is Helm?**
- A tool to define, install, and upgrade complex Kubernetes apps.

**Think of it like:**  
`apt` or `yum` for Kubernetes. Install apps using simple commands.

**Example:**
Install WordPress using Helm:

```bash
helm repo add bitnami https://charts.bitnami.com/bitnami
helm install mysite bitnami/wordpress
```

**Why Use Helm?**
- Simplifies deployment
- Supports versioning and rollbacks
- Easy templating using values files

---

### 🔹 9. **StatefulSets**

**Why StatefulSets?**
- Use when each Pod needs **stable identity** (hostname, storage).
- Ideal for **databases**, **Kafka**, **Redis**, etc.

**Key Features:**
- Persistent storage per Pod
- Ordered, graceful deployment, scaling, and deletion

**Example:**
```yaml
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: mysql
spec:
  serviceName: "mysql"
  replicas: 3
  selector:
    matchLabels:
      app: mysql
  template:
    metadata:
      labels:
        app: mysql
    spec:
      containers:
      - name: mysql
        image: mysql:5.7
        volumeMounts:
        - name: mysql-pvc
          mountPath: /var/lib/mysql
  volumeClaimTemplates:
  - metadata:
      name: mysql-pvc
    spec:
      accessModes: ["ReadWriteOnce"]
      resources:
        requests:
          storage: 1Gi
```

---

### 🔹 10. **DaemonSets**

**Purpose:**
- Ensures a Pod runs **on every node** (or selected nodes).

**Use Case:**
- Log shippers (e.g., Fluentd), monitoring agents (e.g., Prometheus Node Exporter).

```yaml
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: node-monitor
spec:
  selector:
    matchLabels:
      name: node-monitor
  template:
    metadata:
      labels:
        name: node-monitor
    spec:
      containers:
      - name: node-monitor
        image: prom/node-exporter
```

---

### 🔹 11. **Ingress**

**Why Ingress?**
- Acts as a smart router to manage external access to services (HTTP/HTTPS).
- Supports **routing**, **SSL/TLS**, and **host/path-based access**.

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: my-ingress
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  rules:
  - host: myapp.local
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: myservice
            port:
              number: 80
```

---

### 🔹 12. **Horizontal Pod Autoscaler (HPA)**

**Purpose:**
- Automatically scales Pods **based on CPU or custom metrics**.

```yaml
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: hpa-example
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: myapp
  minReplicas: 2
  maxReplicas: 5
  metrics:
  - type: Resource
    resource:
      name: cpu
      target:
        type: Utilization
        averageUtilization: 50
```

> You need to enable `metrics-server` in your cluster.

---

### 🔹 13. **Taints & Tolerations**

**Purpose:**
- Control Pod placement using node restrictions.

**Example Use Case:**
You want only **backend jobs** to run on certain high-memory nodes.

**Taint the node:**
```bash
kubectl taint nodes node1 role=backend:NoSchedule
```

**Allow Pod to tolerate the taint:**
```yaml
tolerations:
- key: "role"
  operator: "Equal"
  value: "backend"
  effect: "NoSchedule"
```

---

### 🔹 14. **Node Affinity & Anti-Affinity**

**Purpose:**
- Schedule Pods on specific nodes **based on labels**.

**Example:**
Run frontend apps on nodes labeled with `zone=frontend`.

```yaml
affinity:
  nodeAffinity:
    requiredDuringSchedulingIgnoredDuringExecution:
      nodeSelectorTerms:
      - matchExpressions:
        - key: zone
          operator: In
          values:
          - frontend
```

---

### 🔹 15. **Resource Requests & Limits**

**Why?**
- Prevent one Pod from taking all resources.
- Helps the scheduler decide placement.

```yaml
resources:
  requests:
    memory: "128Mi"
    cpu: "250m"
  limits:
    memory: "256Mi"
    cpu: "500m"
```

---

### 🔹 16. **RBAC (Role-Based Access Control)**

**Purpose:**
- Secure your cluster by controlling **who can do what**.

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: dev
  name: dev-reader
rules:
- apiGroups: [""]
  resources: ["pods"]
  verbs: ["get", "watch", "list"]
```

Bind role to user:
```yaml
kind: RoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: dev-user-binding
  namespace: dev
subjects:
- kind: User
  name: alice
roleRef:
  kind: Role
  name: dev-reader
  apiGroup: rbac.authorization.k8s.io
```

---
### 🔹 17. **Init Containers**

**What is it?**
- Runs **before** the main container in a Pod.
- Used for **setup tasks**, like downloading files, waiting for services, or checking dependencies.

**Real Example:**
Before running your app, you want to fetch configs or secrets from a secure location.

```yaml
spec:
  initContainers:
  - name: init-config
    image: busybox
    command: ['sh', '-c', 'wget https://example.com/config.json -O /app/config.json']
    volumeMounts:
    - mountPath: /app
      name: config-volume
  containers:
  - name: main-app
    image: myapp:latest
    volumeMounts:
    - mountPath: /app
      name: config-volume
```

---

### 🔹 18. **Ephemeral Containers**

**Purpose:**
- Used **only for debugging** live Pods.
- They don't become part of the Pod spec or restart automatically.

```bash
kubectl debug -it mypod --image=busybox --target=myapp-container
```

👉 This lets DevOps inspect issues **inside running Pods** without modifying deployments.

---

### 🔹 19. **Sidecar Containers**

**What is it?**
- Extra containers **within the same Pod** to assist the main container.
- Can do logging, monitoring, or proxying.

**Example Use Case:**
Add a logging sidecar that ships logs to a remote server.

```yaml
spec:
  containers:
  - name: main-app
    image: myapp:latest
    volumeMounts:
    - name: shared-logs
      mountPath: /logs
  - name: log-shipper
    image: log-collector
    volumeMounts:
    - name: shared-logs
      mountPath: /logs
```

---

### 🔹 20. **Finalizers**

**Purpose:**
- Prevent objects from being deleted until **cleanup tasks** are done.
- Common with CRDs (Custom Resource Definitions), PVCs, etc.

**Example:**
Don’t delete a database CRD until the backup is completed.

```yaml
metadata:
  finalizers:
    - db.cleanup.kubernetes.io
```

You must remove the finalizer manually after the task is done.

---

### 🔹 21. **Custom Resources & CRDs**

**Why Custom Resources?**
- Extend Kubernetes capabilities by creating your own API types.

**Example:**
You want to create a new resource called `Database` with custom spec.

```yaml
apiVersion: myorg.com/v1
kind: Database
metadata:
  name: my-db
spec:
  engine: postgres
  version: "13"
  storage: 5Gi
```

You need to first create a **CustomResourceDefinition (CRD)**.

---

### 🔹 22. **Admission Controllers**

**What are they?**
- They are plugins that **intercept requests** to the Kubernetes API.
- Used to enforce policies (e.g., require labels, deny privileged containers, etc.)

Example use case:
Block all Pods that do not have a `team` label.

🔒 These are great for implementing **security, policy enforcement**, and **governance**.

---

### 🔹 23. **PodDisruptionBudget (PDB)**

**Why?**
- Helps maintain **app availability** during voluntary disruptions (like node upgrades).

```yaml
apiVersion: policy/v1
kind: PodDisruptionBudget
metadata:
  name: myapp-pdb
spec:
  minAvailable: 2
  selector:
    matchLabels:
      app: myapp
```

👉 This ensures at least 2 Pods are always available.

---

### 🔹 24. **PriorityClasses**

**Why?**
- Define **priority levels** for Pods, so that during resource crunch, **low-priority Pods are evicted first**.

```yaml
apiVersion: scheduling.k8s.io/v1
kind: PriorityClass
metadata:
  name: high-priority
value: 100000
globalDefault: false
description: "This priority class should be used for critical workloads."
```

Then use it in your Pod:
```yaml
spec:
  priorityClassName: high-priority
```

---

### 🔹 25. **ServiceAccounts**

**Purpose:**
- A way for Pods to **authenticate to the Kubernetes API** or other services.

**Example:**
Assign a Pod a limited role to list secrets:
```yaml
spec:
  serviceAccountName: limited-reader
```

---


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
