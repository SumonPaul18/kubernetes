# 📦 Kubernetes Guide - Complete Beginner to Advanced

<div align="center">
	<img width = "33%" src="https://github.com/SumonPaul18/kubernetes/blob/main/images/Kubernetes.png?raw=true">
</div>

Welcome to the **Kubernetes** repository! This is your one-stop destination to learn Kubernetes from scratch to advanced level with **detailed theory, practical examples**, and **real-world use cases**.

---

## 📚 Table of Contents

### 🧠 Introduction
- [What is Kubernetes?](#what-is-kubernetes)
- [Pros & Cons of Kubernetes?](#why-kubernetes)
- [Kubernetes Architecture](#kubernetes-architecture)
- [Key Components](#key-components)

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

![Kubernetes Architecture Diagram](https://d33wubrfki0l68.cloudfront.net/9c15608dd700dd1573b0636e84de0196e51bd759/cf98e/images/docs/components-of-kubernetes.svg)

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



---

## Definitions
- **Pod**: The smallest and simplest Kubernetes object. A Pod represents a set of running containers on your cluster.
- **Node**: A worker machine in Kubernetes, which can be a VM or a physical machine.
- **Cluster**: A set of nodes that run containerized applications managed by Kubernetes.
- **Service**: An abstraction which defines a logical set of Pods and a policy by which to access them.

### 2. ⚙️ Installation & Setup

#### A. Local (Minikube)
**[Install Kubernetes using Minikube](https://github.com/SumonPaul18/kubernetes/blob/main/install-minikube.md)**

#### B. Multi-node Cluster (kubeadm)
**[Install Kubernetes using KubeAdm](https://github.com/SumonPaul18/kubernetes/tree/main/install-kubeadm)**

#### C. Cloud Providers

- **GKE: Google Kubernetes Engine**

- **EKS: AWS**

- **AKS: Azure Kubernetes Service**

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
