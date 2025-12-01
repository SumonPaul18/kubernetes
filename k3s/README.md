# 🚀 **K3s + GitOps with FluxCD: The Complete Practical Guide for DevOps Engineers**

> **Lightweight. Reliable. GitOps-First.**  
> Deploy and manage real-world Kubernetes workloads from a single Raspberry Pi to your home lab — no cloud required.

---

## 📚 Table of Contents

- [🎯 Who Is This For?](#-who-is-this-for)
- [💡 What Is K3s?](#-what-is-k3s)
  - [🎯 Purpose & Philosophy](#-purpose--philosophy)
  - [✔️ Key Benefits](#️-key-benefits)
  - [⚖️ K3s vs Other Distributions](#️-k3s-vs-other-distributions)
  - [🚫 Limitations](#-limitations)
- [🏡 Real-World Use Cases](#-real-world-use-cases)
- [🔧 K3s Deep Dive: Components & Architecture](#-k3s-deep-dive-components--architecture)
- [📥 Step-by-Step: Install K3s (Single & Multi-Node)](#-step-by-step-install-k3s-single--multi-node)
- [⚙️ Core Operations: Pods, Deployments, Services, Ingress, Storage](#️-core-operations-pods-deployments-services-ingress-storage)
- [🔁 GitOps with FluxCD: From Zero to Production-Ready](#-gitops-with-fluxcd-from-zero-to-production-ready)
  - [🧩 Multi-Repo GitOps Setup](#-multi-repo-gitops-setup)
  - [🔄 Disconnect & Reconnect GitHub](#-disconnect--reconnect-github)
- [🧰 Troubleshooting & Maintenance](#-troubleshooting--maintenance)
- [✅ Best Practices for Home Labs & Production Edge](#-best-practices-for-home-labs--production-edge)
- [🚀 Next Steps & Advanced Topics](#-next-steps--advanced-topics)
- [🪴 Final Thought](#-final-thought)

---

## 🎯 Who Is This For?

- **DevOps Engineers** managing home labs or edge infrastructure
- **Cloud professionals** exploring lightweight, self-hosted alternatives to public cloud
- **Bengali-speaking IT practitioners** seeking clear, step-by-step technical guidance
- Anyone who values **simplicity**, **automation**, and **infrastructure-as-code**

> ✨ You don’t need expensive hardware. Just a spare machine, internet, and curiosity.

---

## 💡 What Is K3s?

**K3s** is a **certified, lightweight Kubernetes distribution** built for production workloads in resource-constrained environments. Developed by Rancher (now SUSE), it strips away unnecessary dependencies while preserving 100% Kubernetes API compatibility.

### 🎯 Purpose & Philosophy

- **Simplify Kubernetes**: Reduce operational complexity.
- **Enable Edge & IoT**: Run K8s on devices with 512MB RAM.
- **Single Binary**: No etcd, no Docker daemon, no kubelet sprawl.
- **Batteries Included**: Bundles essential components (containerd, CoreDNS, Traefik, local-path-provisioner, service LB).

### ✔️ Key Benefits

| Feature | Why It Matters |
|--------|----------------|
| **<100MB binary** | Fits on embedded devices |
| **512MB RAM min** | Runs on Raspberry Pi, old laptops |
| **No external dependencies** | No need for etcd or Docker |
| **Auto TLS & Cert rotation** | Secure by default |
| **Built-in Ingress** | Traefik included out-of-the-box |
| **CNCF Certified** | Fully compatible with Kubernetes tools |

### ⚖️ K3s vs Other Distributions

| Tool | Best For | RAM Usage | Production-Ready? |
|------|--------|----------|------------------|
| **K3s** | Edge, IoT, Home Lab, CI | **512MB+** | ✅ Yes |
| **K3d** | Local dev (Docker-based) | ~1GB | ❌ No |
| **Minikube** | Learning Kubernetes | 2GB+ | ❌ No |
| **Standard K8s** | Enterprise scale | 4GB+/node | ✅ Yes |
| **EKS/AKS/GKE** | Managed cloud | $$$ | ✅ Yes |

### 🚫 Limitations

- Not ideal for **large-scale, multi-tenant** clusters
- Limited HA options in ultra-small setups (needs ≥2 server nodes)
- No native Docker support (uses containerd by default — but you can add Docker)

> ⚠️ **But**: For **90% of home labs, edge apps, and small teams**, K3s is **more than enough**.

---

## 🏡 Real-World Use Cases

| Scenario | How K3s Helps |
|--------|---------------|
| **Home Lab DevOps Practice** | Run full K8s stack on Ubuntu desktop |
| **IoT Gateway** | Deploy sensor processing on ARM devices |
| **Disaster Recovery Node** | Lightweight backup cluster in remote office |
| **CI/CD Test Cluster** | Spin up ephemeral clusters for pipeline testing |
| **Retail Edge Store** | Run inventory + POS apps locally during internet outage |

> 💡 Your **home lab with public IPs and live DevOps projects** is the **perfect** K3s playground.

---

## 🔧 K3s Deep Dive: Components & Architecture

K3s bundles everything into a single process (`/usr/local/bin/k3s`) but runs logically separate components:

```
k3s server
├── containerd                     # Container runtime
├── kubelet                        # Node agent
├── kube-apiserver                 # API server
├── kube-scheduler                 # Pod scheduler
├── kube-controller-manager        # Core controllers
├── CoreDNS                        # DNS service
├── Traefik                        # Ingress controller (default)
├── local-path-provisioner         # Dynamic local storage
├── servicelb                      # Built-in load balancer for NodePort/LoadBalancer
└── SQLite (or external db)        # Lightweight datastore (default: embedded SQLite)
```

> 🔄 All components are **automatically managed** — no manual restarts needed.

---

## 📥 Step-by-Step: Install K3s (Single & Multi-Node)

### 🧪 Prerequisites
- Ubuntu 22.04/24.04 (or any Linux with systemd)
- 1+ vCPU, 1GB+ RAM (2GB+ recommended)
- Static IP (optional but recommended)

### 1️⃣ Single-Node (All-in-One)

```bash
# Install (server + worker in one)
curl -sfL https://get.k3s.io | sh -

# Verify
kubectl get nodes
sudo systemctl status k3s
```

### 2️⃣ Multi-Node Setup

**Server Node (Control Plane):**
```bash
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--write-kubeconfig-mode 644" sh -
sudo cat /var/lib/rancher/k3s/server/node-token  # Save this token!
```

**Worker Node:**
```bash
curl -sfL https://get.k3s.io | K3S_URL=https://<SERVER_IP>:6443 K3S_TOKEN=<TOKEN> sh -
```

> ✅ Now you have a **real HA-capable cluster**.

---

## ⚙️ Core Operations: Pods, Deployments, Services, Ingress, Storage

### 🧱 Deployments & Pods
```yaml
# nginx.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deploy
spec:
  replicas: 2
  selector: { matchLabels: { app: nginx } }
  template:
    metadata: { labels: { app: nginx } }
    spec:
      containers:
      - name: nginx
        image: nginx:alpine
        ports: [{ containerPort: 80 }]
```

```bash
kubectl apply -f nginx.yaml
kubectl get pods
```

### 🌐 Services & Ingress
```yaml
# service.yaml
apiVersion: v1
kind: Service
meta
  name: nginx-svc
spec:
  selector: { app: nginx }
  ports: [{ port: 80, targetPort: 80 }]
  type: NodePort  # or LoadBalancer (if MetalLB installed)
```

```yaml
# ingress.yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
meta
  name: nginx-ingress
spec:
  rules:
  - host: nginx.local
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: nginx-svc
            port: { number: 80 }
```

> 🔍 Access via: `http://nginx.local` (add to `/etc/hosts`)

### 💾 Persistent Storage
K3s includes **local-path-provisioner** by default:
```yaml
# pvc.yaml
apiVersion: v1
kind: PersistentVolumeClaim
meta
  name: test-pvc
spec:
  accessModes: ["ReadWriteOnce"]
  storageClassName: local-path
  resources: { requests: { storage: 1Gi } }
```

> 📁 Data persists in: `/var/lib/rancher/k3s/storage/`

---

## 🔁 GitOps with FluxCD: From Zero to Production-Ready

> **GitOps = Declarative + Automated + Auditable**  
> Your Git repo **is** your system of truth.

### 🚀 Bootstrap FluxCD (Single Repo)

```bash
flux bootstrap github \
  --owner=your-username \
  --repository=cluster-config \
  --branch=main \
  --path=clusters/home-lab \
  --personal
```

### 🧩 Multi-Repo GitOps Setup

Separate concerns into dedicated repos:

| Repo | Purpose |
|------|--------|
| `infra-repo` | MetalLB, Ingress, Monitoring |
| `app-repo` | WordPress, Nginx, Custom apps |
| `secrets-repo` | (Encrypted) with SOPS |

**Example: Connect app-repo**
```yaml
# apps-git.yaml
apiVersion: source.toolkit.fluxcd.io/v1beta2
kind: GitRepository
meta
  name: app-repo
  namespace: flux-system
spec:
  url: https://github.com/your-username/app-repo
  ref: { branch: main }
  interval: 30s

---
apiVersion: kustomize.toolkit.fluxcd.io/v1beta2
kind: Kustomization
meta
  name: apps
  namespace: flux-system
spec:
  sourceRef: { kind: GitRepository, name: app-repo }
  path: ./production
  prune: true
  interval: 5m
```

Apply with: `kubectl apply -f apps-git.yaml`

### 🔄 Disconnect & Reconnect GitHub

**To disconnect a repo:**
```bash
kubectl delete gitrepository app-repo -n flux-system
kubectl delete kustomization apps -n flux-system
```

**To reconnect:**
- Edit YAML → change URL or branch → `kubectl apply -f`
- Or use `flux create` commands

> ✅ No cluster restart needed. GitOps is **dynamic**.

---

## 🧰 Troubleshooting & Maintenance

### 🔍 Common Checks
```bash
# Flux status
flux check
flux get all -A

# K3s logs
sudo journalctl -u k3s -f

# All pods
kubectl get pods -A

# Ingress not working?
kubectl describe ingress <name>
kubectl logs -n kube-system -l app=traefik
```

### 🧹 Clean Reinstall (If Broken)
```bash
# Uninstall K3s
/usr/local/bin/k3s-uninstall.sh

# Uninstall Flux
flux uninstall --silent

# Remove leftovers
sudo rm -rf /var/lib/rancher/k3s
kubectl delete crd -l app.kubernetes.io/part-of=flux
```

> 🔄 Then reinstall fresh!

---

## ✅ Best Practices for Home Labs & Production Edge

1. **Use separate repos** for infra vs apps
2. **Enable `prune: true`** in Kustomizations
3. **Encrypt secrets** with **SOPS + Age**
4. **Use static IPs** or DHCP reservations
5. **Monitor** with **Prometheus + Grafana** (deploy via Flux!)
6. **Backup** K3s etcd (or SQLite) regularly
7. **Test failover** — power off nodes intentionally!

---

## 🚀 Next Steps & Advanced Topics

- [ ] **SOPS Secret Management**: Encrypt `passwords.yml`, DB credentials
- [ ] **Multi-Cluster GitOps**: Manage staging + prod from one repo
- [ ] **Custom Metrics + HPA**: Scale apps based on CPU/RAM
- [ ] **K3s + Ceph/Rook**: Distributed storage on bare metal
- [ ] **FluxCD Dashboard**: Visual GitOps status
- [ ] **Automated OS Updates**: With K3s + Ansible + GitOps

---

## 🪴 Final Thought

> **Technology mirrors life**:  
> Just as a garden thrives with care, pruning, and the right conditions —  
> so does a Kubernetes cluster.  
>  
> Start small. Grow steadily. Automate everything.  
> And never stop learning.

---

> 💬 **Made with ❤️ for DevOps engineers who believe in self-hosted resilience.**  
> ✨ **Your home lab is your castle. Fortify it with GitOps.**

---

**📄 File**: `README.md`  
**Author**: Based on real-world DevOps practice (Sumon – 8+ years in IT Infrastructure & Cloud)  
**License**: MIT (feel free to adapt, share, and build upon)

---

> 💡 **Tip**: Save this as `README.md` in your `cluster-config` GitHub repo — it becomes your **living documentation**!

Let me know if you'd like this as a downloadable `.md` file or want a companion **diagram** of the architecture!
