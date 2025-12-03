# Details of Kong Ingress Controller (KIC)

- ১। Kong Ingress Controller (KIC) কি ? 
- ২। Kong Ingress Controller কি সম্পূর্ণ open source? 
- ৩। Kong Ingress Controller এর সুবিধা কি এবং অসুবিধা কি? 
- ৪। Kong Ingress Controller এর মত সম্পূর্ণ open source বিকল্প কি আছে ?
- ৫। Kong Ingress Controller এর মত অন্য Tools এর মধ্যে পার্থক্য। 
- ৬। Kong Ingress Controller কখন, কেনো আর কিভাবে ব্যবহার করতে হয়?
- ৭। Kong Ingress Controller ছাড়াও Kong এর আর কি কি Tools আছে যা সম্পূর্ণ open source হিসাবে ব্যবহার করা যাই?
- ৮। Kong Ingress Controller কিভাবে ইন্সটল করতে হয় এবং কনফিগার করতে হয়?
- ৯। Kong Ingress Controller ইন্সটল ও কনফিগার করার পরে কিভাবে ব্যাসিক ব্যবহার করতে হয়?
- ১০। Kong Ingress Controller আসলো আমাদের কি কাজ করে দিবে তা একদম বাস্তব কাজের উদাহরণ দিবেন।
- ১১। Kong Ingress Controller (KIC) & Kong Gateway, Gateway API এর গুলো সম্পর্কে বিস্তারিত বলুন। এগুলো কি কেনো কখন কিভাবে, কি কি করা যাই বাস্তব উদাহরণ, ব্যবহার ইত্যাদি সব সকল তথ্য দিবেন।
- ১২। Kong Ingress Controller (KIC) & Kong Gateway, Gateway API এগুলো কিভাবে ব্যবহার করতে হয়। মানে কিভাবে k3s এবং k8s এ ইন্সটল করে কাজ করবো , কনফিগার করবো আমাকে ধাপে-ধাপে একদম সহজ ভাবে শেখান।

---
### **১। Kong Ingress Controller (KIC) কি?**

**Kong Ingress Controller (KIC)** হলো একটি **Kubernetes-native controller** যা Kubernetes ingress resources-এর ভিত্তিতে Kong Gateway-এর কনফিগারেশন অটোমেটিকভাবে ম্যানেজ করে।

> সহজ কথায়: আপনি যখন Kubernetes-এর `Ingress` অবজেক্ট তৈরি করবেন, KIC সেটা দেখে Kong Gateway-কে বলে দেবে কিভাবে traffic route করতে হবে — কোন সার্ভিসে, কোন path-এ, কোন protocol-এ ইত্যাদি।

---

### **২। Kong Ingress Controller কি সম্পূর্ণ open source?**

**হ্যাঁ**, KIC-এর **core version সম্পূর্ণ open-source (Apache 2.0 license)**।  
অবশ্য **Kong Enterprise**-এ অতিরিক্ত ফিচার (যেমন: Developer Portal, RBAC, Advanced Observability) থাকে, সেগুলো proprietary।

> তবে **Kong Gateway (OSS)** + **Kong Ingress Controller (OSS)** = 100% open-source stack.

---

### **৩। Kong Ingress Controller এর সুবিধা এবং অসুবিধা**

#### ✅ **সুবিধা**:
- **শক্তিশালী routing**: path, header, method ভিত্তিক routing।
- **Built-in plugins**: rate-limiting, JWT, OAuth2, logging, CORS ইত্যাদি 150+ plugins।
- **Scalable & performant**: NGINX-based, খুব fast।
- **GitOps-friendly**: YAML দিয়ে সবকিছু declare করা যায়।
- **Kubernetes-native**: CRDs (Custom Resource Definitions) দিয়ে advanced config সম্ভব।
- **Hybrid mode**: DP (Data Plane) ও CP (Control Plane) আলাদা করা যায়।

#### ❌ **অসুবিধা**:
- **লার্নিং কার্ভ**: Ingress + Kong CRDs + plugins = শুরুতে কিছুটা জটিল।
- **Resource overhead**: ছোট cluster-এ অপেক্ষাকৃত ভারী (তবে সহজে optimize করা যায়)।
- **Enterprise vs OSS confusion**: কখনো কখনো ডকুমেন্টেশনে enterprise feature মিশে থাকে।
- **No built-in dashboard (OSS)**: GUI চাইলে Konga (3rd party) বা Kuma GUI ব্যবহার করতে হয়।

---

### **৪। KIC-এর মতো সম্পূর্ণ open-source বিকল্পগুলো কী কী?**

| Tool | License | Key Features |
|------|--------|--------------|
| **Traefik** | MIT | Auto-discovery, Let’s Encrypt, middleware, dashboard (OSS) |
| **NGINX Ingress Controller** | Apache 2.0 | NGINX ভিত্তিক, stable, widely used |
| **HAProxy Ingress** | GPL | High-performance L7 load balancer |
| **Apache APISIX Ingress** | Apache 2.0 | Dynamic config, cloud-native, plugin-rich |
| **Kuma (with Kuma Gateway)** | Apache 2.0 | Service Mesh + Gateway, multi-zone |

> **বাস্তব ব্যবহারে**:  
> - সহজ ও মডার্ন UI চাইলে → **Traefik**  
> - High-performance + plugin flexibility → **APISIX**  
> - Mesh + Gateway একসাথে → **Kuma**  
> - Enterprise-grade OSS → **Kong**

---

### **৫। KIC vs অন্যান্য Ingress Tools – পার্থক্য**

| Feature | **Kong** | **Traefik** | **NGINX** | **APISIX** |
|--------|---------|------------|----------|----------|
| Plugin system | ✅ (150+) | ✅ (Middleware) | ⚠️ (Limited) | ✅ (70+) |
| Dynamic config reload | ✅ | ✅ | ⚠️ (Requires reload) | ✅ |
| Dashboard (OSS) | ❌ | ✅ | ❌ | ✅ |
| Service Mesh | ❌ (But Kuma available) | ❌ | ❌ | ✅ (via APISIX mesh) |
| Gateway API support | ✅ (v3+) | ✅ | ✅ (experimental) | ✅ |
| Deployment simplicity | Medium | Easy | Easy | Medium |

---

### **৬। KIC কখন, কেনো, কিভাবে ব্যবহার করবেন?**

#### 🕒 **কখন?**
- যখন আপনার **advanced traffic control** লাগবে (e.g. JWT auth + rate limit + logging)।
- যখন **API Gateway** হিসেবে ingress ব্যবহার করতে চান।
- যখন **plugin-based extensibility** দরকার।

#### ❓ **কেনো?**
- Kubernetes-native হওয়া সত্ত্বেও **production-grade API gateway** হিসেবে কাজ করে।
- **Centralized policy enforcement** (e.g. all APIs must have rate-limiting)।

#### 🔧 **কিভাবে?**
1. Kong Gateway + KIC deploy করুন (Helm বা YAML)।
2. `Ingress` বা `KongIngress` CRD দিয়ে route define করুন।
3. `KongPlugin` দিয়ে auth/rate-limit যোগ করুন।

---

### **৭। Kong এর আর কি কি open-source tools আছে?**

| Tool | Purpose | OSS? |
|------|--------|------|
| **Kong Gateway** | API Gateway / Ingress | ✅ |
| **Kong Ingress Controller** | Kubernetes integration | ✅ |
| **Kuma** | Service Mesh (Envoy-based) | ✅ |
| **Deck (Kong Gateway declarative config)** | GitOps for Kong | ✅ |
| **Koko** | CLI tool for Kong | ✅ |
| **Kong Admin API** | REST API for config | ✅ |

> **Kong Enterprise**-এর tools (e.g. Dev Portal, Vitals) proprietary।

---

### **৮। KIC কিভাবে install & configure করবেন?**

#### ✅ **Step-by-step (K3s/K8s-এ)**

```bash
# 1. Add Helm repo
helm repo add kong https://charts.konghq.com
helm repo update

# 2. Create namespace
kubectl create namespace kong

# 3. Install Kong + KIC (OSS version)
helm install kong kong/kong \
  --namespace kong \
  --set ingressController.enabled=true \
  --set ingressController.installCRDs=true \
  --set proxy.type=LoadBalancer  # or NodePort for labs
```

> **Note**:  
> - `proxy.type=NodePort` → home lab / local dev  
> - `proxy.type=LoadBalancer` → cloud (e.g. AWS, GCP)

---

### **৯। Install পরে বেসিক ব্যবহার কিভাবে?**

#### উদাহরণ: একটি সাদামাটা `hello-world` সার্ভিসে traffic route করুন

```yaml
# 1. Deploy a sample app
kubectl create deploy hello --image=nginxdemos/hello
kubectl expose deploy hello --port=80

# 2. Create Ingress
apiVersion: networking.k8s.io/v1
kind: Ingress
meta
  name: hello-ingress
  namespace: default
  annotations:
    konghq.com/plugins: my-rate-limit
spec:
  rules:
  - host: hello.local
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: hello
            port:
              number: 80
```

#### Rate-limit plugin add করুন:

```yaml
apiVersion: configuration.konghq.com/v1
kind: KongPlugin
meta
  name: my-rate-limit
plugin: rate-limiting
config:
  minute: 5
```

> এখন `curl -H "Host: hello.local" http://<KONG_PROXY_IP>` করলে 5 req/min লিমিট পাবেন।

---

### **১০। বাস্তব উদাহরণ: KIC আপনার কী কাজ করে দেবে?**

**Scenario**: আপনার একটি E-commerce API আছে (product, cart, payment)।

#### KIC দিয়ে আপনি করতে পারবেন:
- `api.example.com/product` → product service
- `api.example.com/cart` → cart service
- **JWT authentication** on `/payment`
- **Rate-limit**: 100 req/min per user
- **Logging** to Loki or Splunk
- **CORS** enable for frontend
- **TLS termination** at Kong

> একটি Ingress + কয়েকটি plugin দিয়েই সব কনফিগারেশন করা যাবে — **কোনো custom code লাগবে না**।

---

### **১১। KIC, Kong Gateway, Gateway API – বিস্তারিত**

| Component | Role |
|----------|------|
| **Kong Gateway** | Actual proxy (NGINX + Lua) — traffic handle করে |
| **Kong Ingress Controller (KIC)** | Kubernetes থেকে Kong Gateway-এর config sync করে |
| **Kubernetes Ingress** | Legacy standard (host/path based) |
| **Gateway API** | New Kubernetes standard (more flexible: Routes, Gateways, TLS, etc.) |

#### 💡 **Gateway API vs Ingress**:
- **Ingress**: single resource, limited
- **Gateway API**: roles split (admin creates `Gateway`, dev creates `HTTPRoute`) → better RBAC

#### ✅ **Kong supports both**:
- Traditional `Ingress`
- Modern `Gateway API` (from v3.0+)

> **Example (Gateway API)**:
> ```yaml
> kind: Gateway
> spec:
>   listeners:
>   - name: http
>     port: 80
>     protocol: HTTP
> ---
> kind: HTTPRoute
> spec:
>   parentRefs:
>   - name: my-gateway
>   rules:
>   - matches:
>     - path: /api
>     backendRefs:
>     - name: my-service
> ```

---

### **১২। K3s/K8s-এ KIC + Kong Gateway ধাপে ধাপে install & use**

#### ✅ **Step 1: K3s cluster চালু আছে তো?**
```bash
k3s kubectl get nodes
```

#### ✅ **Step 2: Helm install করুন (যদি না থাকে)**
```bash
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
```

#### ✅ **Step 3: Kong install (NodePort for home lab)**
```bash
helm install kong kong/kong \
  --namespace kong \
  --create-namespace \
  --set ingressController.enabled=true \
  --set ingressController.installCRDs=true \
  --set proxy.type=NodePort \
  --set admin.enabled=true \
  --set admin.type=NodePort
```

#### ✅ **Step 4: IP & Ports চেক করুন**
```bash
kubectl -n kong get svc
# proxy এর NodePort (e.g. 32080)
# admin এর NodePort (e.g. 32081)
```

#### ✅ **Step 5: টেস্ট অ্যাপ ডিপ্লয়**
```bash
kubectl create deploy test --image=nginxdemos/hello
kubectl expose deploy test --port=80
```

#### ✅ **Step 6: Ingress create**
```yaml
# ingress.yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
meta
  name: test-ingress
spec:
  rules:
  - http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: test
            port:
              number: 80
```
```bash
kubectl apply -f ingress.yaml
```

#### ✅ **Step 7: টেস্ট করুন**
```bash
curl -H "Host: dummy" http://<NODE_IP>:<PROXY_NODEPORT>
# "Hello World" আসবে
```

#### ✅ **Step 8: Plugin add (e.g. rate-limit)**
```yaml
apiVersion: configuration.konghq.com/v1
kind: KongPlugin
meta
  name: global-rate-limit
plugin: rate-limiting
config:
  second: 2
---
apiVersion: networking.k8s.io/v1
kind: Ingress
meta
  name: test-ingress
  annotations:
    konghq.com/plugins: global-rate-limit
# ... rest same
```

> এবার 2 req/sec এর বেশি করলে `429 Too Many Requests` পাবেন।

---

### 🔚 **শেষ কথা**

Kong Ingress Controller শুধু "traffic router" নয় — এটি একটি **full-fledged API Gateway** যা Kubernetes-কে **production-ready API management layer** দেয়।  
আপনার private cloud lab, DevOps pipeline, বা production cluster — যেকোনো জায়গায় এটি দারুণ কাজ করবে, শর্ত হলো OSS features-এর মধ্যেই থাকা।

> **Technology is not just about routing packets — it’s about routing possibilities with precision, security, and grace.**

