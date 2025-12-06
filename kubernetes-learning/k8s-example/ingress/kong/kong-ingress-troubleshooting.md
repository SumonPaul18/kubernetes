# Kong Ingress Controller Installation & Troubleshooting Guide  
## A Comprehensive Solution for Common Helm and CRD Errors in Kubernetes  

> **Prepared for:** DevOps Engineers & Kubernetes Practitioners  
> **Target Environment:** K3s / Vanilla Kubernetes with Helm 3  
> **Use Case:** Deploying Kong as an Ingress Controller using official Helm charts  

---

## 📌 Table of Contents

1. [Overview](#-overview)  
2. [Common Error: CRD Ownership Metadata Missing](#-common-error-crd-ownership-metadata-missing)  
3. [Root Cause Analysis](#-root-cause-analysis)  
4. [Step-by-Step Solutions](#-step-by-step-solutions)  
   - ✅ Option 1: Clean Reinstall (Recommended for Dev/Lab)  
   - ⚙️ Option 2: Keep Existing CRDs (Use in Production)  
5. [Verifying Kong Installation](#-verifying-kong-installation)  
6. [Deploying a Test Application with Ingress](#-deploying-a-test-application-with-ingress)  
7. [Alternative: Use `kong/ingress` Chart (Official Recommendation)](#-alternative-use-kongingress-chart-official-recommendation)  
8. [Additional Common Kong Ingress Errors & Fixes](#-additional-common-kong-ingress-errors--fixes)  
9. [Best Practices & Pro Tips](#-best-practices--pro-tips)  
10. [References](#-references)  

---

## 🌐 Overview

Kong is a powerful, scalable API Gateway and Ingress Controller for Kubernetes. It can be deployed via Helm using two official charts from [Kong’s Helm repository](https://charts.konghq.com):

- **`kong/ingress`**: Opinionated, DB-less, controller + gateway combo. **Recommended for new installations**.
- **`kong/kong`**: Flexible, supports hybrid mode, database-backed, or unmanaged deployments.

However, users often encounter Helm installation failures due to **CustomResourceDefinition (CRD) ownership conflicts**, especially when re-installing or migrating Kong setups.

This guide provides a complete troubleshooting and deployment path — from fixing the `meta.helm.sh/release-name` error to validating end-to-end traffic flow.

---

## ❌ Common Error: CRD Ownership Metadata Missing

### 🔴 Error Message
```text
Error: INSTALLATION FAILED: Unable to continue with install: 
CustomResourceDefinition "ingressclassparameterses.configuration.konghq.com" in namespace "" exists and cannot be imported into the current release: 
invalid ownership metadata; 
label validation error: missing key "app.kubernetes.io/managed-by": must be set to "Helm"; 
annotation validation error: missing key "meta.helm.sh/release-name": must be set to "kong"; 
annotation validation error: missing key "meta.helm.sh/release-namespace": must be set to "kong"
```

This occurs when:
- CRDs were previously installed **manually** (e.g., via `kubectl apply -f https://...`)  
- Or installed by a **different Helm release**  
- Or Helm uninstall failed to clean up CRDs (they are cluster-scoped)

Helm v3+ enforces **immutable ownership** on cluster-scoped resources like CRDs.

---

## 🔍 Root Cause Analysis

- Kong’s Helm chart (`kong/kong`) attempts to **install CRDs** when `ingressController.installCRDs=true` (default).
- But Kubernetes **does not allow ownership transfer** of existing CRDs.
- Helm requires **specific labels & annotations** to claim ownership:
  ```yaml
  metadata:
    labels:
      app.kubernetes.io/managed-by: Helm
    annotations:
      meta.helm.sh/release-name: <your-release>
      meta.helm.sh/release-namespace: <your-namespace>
  ```

If these are missing → **Helm refuses to proceed**.

---

## ✅ Step-by-Step Solutions

### ✅ Option 1: Clean Reinstall (Recommended for Dev/Lab Environments)

> Use this if you **don’t have production Kong resources** (e.g., `KongPlugin`, `KongConsumer`).

#### Step 1: Delete All Kong CRDs
```bash
kubectl delete crd \
  kongclusterplugins.configuration.konghq.com \
  kongconsumers.configuration.konghq.com \
  kongingresses.configuration.konghq.com \
  kongplugins.configuration.konghq.com \
  tcpingresses.configuration.konghq.com \
  udpingresses.configuration.konghq.com \
  ingressclassparameterses.configuration.konghq.com
```

> ⚠️ **Warning**: This will **delete all custom Kong resources** in the cluster.

#### Step 2: Reinstall Kong with CRD Installation Enabled
```bash
kubectl create namespace kong

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

✅ **Success**: Helm now owns the CRDs and manages them.

---

### ⚙️ Option 2: Keep Existing CRDs (Production-Safe)

> Use this if you **cannot afford to lose** Kong custom resources.

#### Step 1: Install Kong **without** managing CRDs
```bash
helm install kong kong/kong \
  --namespace kong \
  --set ingressController.enabled=true \
  --set ingressController.installCRDs=false \  # ⚠️ Critical!
  --set proxy.type=NodePort \
  --set admin.enabled=true \
  --set admin.type=NodePort \
  --set proxy.http.nodePort=32080 \
  --set proxy.tls.nodePort=32443 \
  --set admin.nodePort=32081
```

#### Step 2: Verify CRD Compatibility
Ensure your existing CRDs match the **version expected** by the Helm chart. Mismatched versions may cause controller crashes.

> ℹ️ You can check CRD versions via:
> ```bash
> kubectl get crd kongingresses.configuration.konghq.com -o jsonpath='{.metadata.labels.chart}'
> ```

---

## 🔎 Verifying Kong Installation

After successful install:

```bash
# Check Pods
kubectl -n kong get pods

# Check Services (should show NodePort 32080, 32081, 32443)
kubectl -n kong get svc

# Check CRDs
kubectl get crd | grep kong
```

### Test Proxy Connectivity
```bash
curl http://<NODE_IP>:32080
# Expected: {"message":"no Route matched..."} → ✅ Kong is running!
```

> 🟢 **This is NOT an error** — it means Kong is active but has no routes configured.

---

## 🚀 Deploying a Test Application with Ingress

### Step 1: Deploy a Simple App (`hello`)
```bash
kubectl create deploy hello --image=nginxdemos/hello -n default
kubectl expose deploy hello --port=80 --target-port=80 -n default
```

### Step 2: Create Ingress Resource
```yaml
# hello-ingress.yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: hello-ingress
  namespace: default
  annotations:
    kubernetes.io/ingress.class: kong
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

Apply:
```bash
kubectl apply -f hello-ingress.yaml
```

### Step 3: Test End-to-End Flow
```bash
curl http://172.30.1.2:32080
# ✅ Should return "Hello World" HTML page
```

Success! Kong is routing traffic to your app.

---

## 🔄 Alternative: Use `kong/ingress` Chart (Official Recommendation)

The **`kong/ingress`** chart is **simpler, safer, and recommended** for most users:

```bash
helm install kong-ingress kong/ingress \
  --namespace kong \
  --create-namespace \
  --set gateway.nodePort.http=32080 \
  --set gateway.nodePort.https=32443 \
  --set gateway.admin.nodePort=32081
```

> ✅ Advantages:
> - Pre-configured DB-less mode
> - Separates controller & gateway cleanly
> - Avoids manual CRD management
> - Less error-prone

Use this for **new projects**.

---

## ⚠️ Additional Common Kong Ingress Errors & Fixes

| Error / Symptom | Likely Cause | Solution |
|------------------|--------------|--------|
| `no Route matched...` | No Ingress defined | Create Ingress resource |
| `Connection refused` on NodePort | Service not exposed or wrong port | Check `kubectl -n kong get svc` |
| Ingress not picked up | Missing `kubernetes.io/ingress.class: kong` | Add annotation |
| Kong pod CrashLoopBackOff | DB config error or port conflict | Check logs: `kubectl -n kong logs <pod>` |
| Admin API inaccessible | `admin.enabled=false` or wrong NodePort | Enable admin + verify port |
| TLS/HTTPS not working | Missing certificate or wrong port | Use `proxy.tls.nodePort=32443` and configure TLS in Ingress |

---

## 💡 Best Practices & Pro Tips

1. **Always prefer `kong/ingress`** for new deployments.
2. **Never manually edit CRDs** — let Helm manage them.
3. **Use `--set ingressController.installCRDs=false`** in production unless you control the full lifecycle.
4. **Test with simple apps first** (e.g., `nginxdemos/hello`) before deploying real services.
5. **Monitor controller logs**:
   ```bash
   kubectl -n kong logs -l app.kubernetes.io/component=ingress-controller
   ```
6. **Use `kubectl describe ingress <name>`** to debug route issues.

---

## 📚 References

- [Kong Helm Charts Repository](https://charts.konghq.com)  
- [Kong Ingress Controller Documentation](https://docs.konghq.com/kubernetes-ingress-controller/)  
- [Helm CRD Best Practices](https://helm.sh/docs/chart_best_practices/custom_resource_definitions/)  
- [Kong GitHub Issues & Community](https://discuss.konghq.com/)

---

> ✨ **You now have a production-ready, debuggable Kong Ingress setup!**  
> Save this guide for future reference or share it with your team.  

*Authored for DevOps practitioners managing self-hosted Kubernetes environments.*  
*Last verified on Helm v3.17.0, Kong Ingress Controller v3.x, K3s/K8s 1.28+*
