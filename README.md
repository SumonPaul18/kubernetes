# 📦 Kubernetes Guide - Complete Beginner to Advanced

<div align="center">
	<img width = "33%" src="https://github.com/SumonPaul18/kubernetes/blob/main/images/Kubernetes.png?raw=true">
</div>

Welcome to the **Kubernetes** repository! This is your one-stop destination to learn Kubernetes from scratch to advanced level with **detailed theory, practical examples**, and **real-world use cases**.

---

## 📚 Table of Contents

### 🧠 Introduction
- [What is Kubernetes?](#what-is-kubernetes)
- [Why Kubernetes?](#why-kubernetes)
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

Why Use Kubernetes?

- High availability
- Auto-scaling & self-healing
- Platform-agnostic (on-prem, cloud)
- Easy rollout and rollback

Simple Example:

Imagine you need 5 web servers running continuously. Kubernetes keeps all 5 running, restarts them if they crash, and balances traffic.

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
