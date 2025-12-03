# **Kong Ingress Controller (KIC)** এবং **Kong Gateway**-কে **K3s** বা **Kubernetes (K8s)** ক্লাস্টারে **সম্পূর্ণ প্রাথমিক লেভেল থেকে শুরু করে** ধাপে ধাপে ইন্সটল, কনফিগার এবং ব্যবহার করার সহজ গাইড দেওয়া হলো।  

---

## ✅ **প্রয়োজনীয় জিনিসপত্র (Prerequisites)**

1. **K3s বা K8s ক্লাস্টার** ইতিমধ্যে চলছে (1 node হলেও চলবে)  
   → চেক করুন:  
   ```bash
   kubectl get nodes
   ```

2. **Helm 3** ইন্সটল করা আছে  
   → চেক করুন:  
   ```bash
   helm version
   ```
   → না থাকলে ইন্সটল করুন:
   ```bash
   curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
   ```

3. **kubectl** কাজ করছে

---

## 🚀 **ধাপ ১: Kong এর Helm রিপো যোগ করুন**

```bash
helm repo add kong https://charts.konghq.com
helm repo update
```

---

## 🧱 **ধাপ ২: `kong` নেমস্পেস তৈরি করুন**

```bash
kubectl create namespace kong
```

---

## 🛠️ **ধাপ ৩: Kong Gateway + Ingress Controller ইন্সটল করুন**

> 📌 **দুটি মোড আছে**:
> - **DB-less mode (recommended for labs)** → config in-memory, YAML/CRD দিয়ে চলে  
> - **Database-backed mode** → PostgreSQL/Cassandra লাগে (production)

### ✅ **Home Lab / K3s-এর জন্য: DB-less + NodePort**

```bash
helm install kong kong/kong \
  --namespace kong \
  --set ingressController.enabled=true \
  --set ingressController.installCRDs=true \
  --set proxy.type=NodePort \
  --set admin.enabled=true \
  --set admin.type=NodePort \
  --set proxy.http.nodePort=32080 \
  --set proxy.tls.nodePort=32443 \
  --set admin.nodePort=32081
```

> 💡 `NodePort` ব্যবহার করা হচ্ছে কারণ আপনি সম্ভবত **কোনো LoadBalancer (e.g. MetalLB) ছাড়াই** K3s চালাচ্ছেন।

---

## 🔍 **ধাপ ৪: ইন্সটলেশন চেক করুন**

```bash
kubectl -n kong get pods
```

অপেক্ষা করুন যতক্ষণ না সব pod **Running** অবস্থায় আসে (2-3 মিনিট লাগতে পারে)।

```bash
kubectl -n kong get svc
```

আউটপুট এরকম হবে:
```
NAME           TYPE       CLUSTER-IP      PORT(S)                      AGE
kong-proxy     NodePort   10.43.100.10    80:32080/TCP,443:32443/TCP   2m
kong-admin     NodePort   10.43.100.11    8001:32081/TCP               2m
```

> 📌 **গুরুত্বপূর্ণ**:  
> - আপনার **K3s নোডের IP** (e.g. `192.168.0.38`)  
> - **Proxy Port**: `32080` (HTTP traffic)  
> - **Admin API Port**: `32081` (Kong config দেখার/দেবলপমেন্টের জন্য)

---

## 🧪 **ধাপ ৫: টেস্ট অ্যাপ ডিপ্লয় করুন**

```bash
# একটি সহজ HTTP সার্ভিস তৈরি করুন
kubectl create deployment hello --image=nginxdemos/hello
kubectl expose deployment hello --port=80 --target-port=80
```

চেক করুন:
```bash
kubectl get svc hello
```

---

## 🌐 **ধাপ ৬: Ingress রিসোর্স তৈরি করুন (KIC এর জন্য)**

```yaml
# hello-ingress.yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
meta
  name: hello-ingress
  namespace: default
spec:
  rules:
  - http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: hello
            port:
              number: 80
```

Apply করুন:
```bash
kubectl apply -f hello-ingress.yaml
```

---

## 🧪 **ধাপ ৭: টেস্ট করুন — Kong কি কাজ করছে?**

আপনার K3s নোডের IP (ধরুন `192.168.0.38`) ব্যবহার করুন:

```bash
curl -H "Host: dummy" http://192.168.0.38:32080
```

> ⚠️ **Host header দিতে হবে** কারণ Ingress-এ `host` না দিলে default backend হতে পারে।  
> অথবা, Ingress-এ `host` না দিয়েই route করতে চাইলে উপরের YAML-এ `host` লাইন বাদ দিন।

✅ আউটপুট আসবে:
```
<h1>Hello World</h1>
...
```

> 🎉 **Kong Ingress Controller কাজ করছে!**

---

## ⚙️ **ধাপ ৮: Plugin যোগ করুন (e.g. Rate Limiting)**

### 1. KongPlugin তৈরি করুন:

```yaml
# rate-limit.yaml
apiVersion: configuration.konghq.com/v1
kind: KongPlugin
metadata:
  name: my-rate-limit
plugin: rate-limiting
config:
  minute: 5
  policy: local
```

```bash
kubectl apply -f rate-limit.yaml
```

### 2. Ingress-এ annotation যোগ করুন:

```yaml
# hello-ingress.yaml (updated)
apiVersion: networking.k8s.io/v1
kind: Ingress
meta
  name: hello-ingress
  annotations:
    konghq.com/plugins: my-rate-limit   # 👈 এই লাইন যোগ করুন
spec:
  rules:
  - http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: hello
            port:
              number: 80
```

```bash
kubectl apply -f hello-ingress.yaml
```

### 3. টেস্ট করুন:

```bash
for i in {1..7}; do curl -H "Host: dummy" http://192.168.0.38:32080; done
```

6th/7th request-এ **`429 Too Many Requests`** পাবেন।

---

## 🔐 **অপশনাল: TLS / Let’s Encrypt (ভবিষ্যতের জন্য)**

KIC + **cert-manager** দিয়ে automatic TLS করা যায় — এখন না।  
পরে চাইলে গাইড দেব।

---

## 🆚 **K3s vs Full K8s-এ পার্থক্য কি?**

| বিষয় | K3s | Full K8s |
|------|-----|--------|
| ইন্সটল | সহজ (`curl \| sh`) | জটিল (kubeadm, etc.) |
| Resource | কম RAM/CPU | বেশি লাগে |
| LoadBalancer | MetalLB বা NodePort লাগে | Cloud LB (AWS/GCP) |
| Kong ইন্সটল | একই Helm command | একই Helm command |

> **Kong ইন্সটলে K3s vs K8s-এ কোনো পার্থক্য নেই!**  
> শুধু `proxy.type` ঠিক করলেই হবে।

---

## 📌 **ব্যবহারের টিপস (Best Practices for Lab)**

1. **DB-less mode** ব্যবহার করুন → কোনো DB মেইনটেইন করতে হবে না  
2. **NodePort** ব্যবহার করুন → LoadBalancer ছাড়াই টেস্ট করা যাবে  
3. **Kong Admin API** (`:32081`) দিয়ে config debug করুন:
   ```bash
   curl http://192.168.0.38:32081/
   ```
4. **Konga** (3rd party GUI) বা **Insomnia** দিয়ে Admin API দেখতে পারেন

---

## 🧩 **বোনাস: Gateway API ব্যবহার করতে চাইলে**

Kong v3+ **Gateway API** সাপোর্ট করে। চালু করতে হলে:

```bash
helm upgrade kong kong/kong \
  --namespace kong \
  --set gateway.enabled=true \
  --set gatewayController.enabled=true
```

তারপর `Gateway`, `HTTPRoute` ব্যবহার করুন — এটা অ্যাডভান্সড টপিক, প্রথমে Ingress শিখুন।

---

## ✅ **সারসংক্ষেপ**

| ধাপ | কাজ |
|-----|-----|
| 1 | Helm repo add |
| 2 | `kong` namespace |
| 3 | Helm install (NodePort, DB-less) |
| 4 | টেস্ট অ্যাপ ডিপ্লয় |
| 5 | Ingress তৈরি |
| 6 | `curl` দিয়ে টেস্ট |
| 7 | Plugin (e.g. rate-limit) add |
| 8 | আরও শিখুন: JWT, CORS, logging |

---
