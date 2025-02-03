## Kubernetes Network Policies

### Network Policy কী?
Kubernetes এর Network Policy সম্পর্কে জানতে চাওয়ার জন্য ধন্যবাদ! Network Policy হলো একটি গুরুত্বপূর্ণ ফিচার যা আপনাকে ক্লাস্টারের মধ্যে এবং বাইরের ট্রাফিক নিয়ন্ত্রণ করতে সাহায্য করে।

### Network Policy এর প্রকারভেদ:
Network Policy মূলত দুই ধরনের হতে পারে:
1. **Ingress Policy:** এটি নির্ধারণ করে কোন ইনকামিং ট্রাফিক পডে প্রবেশ করতে পারবে।
2. **Egress Policy:** এটি নির্ধারণ করে কোন আউটগোয়িং ট্রাফিক পড থেকে বের হতে পারবে।

### Network Policy তৈরি করা:
   - একটি Network Policy তৈরি করতে হলে আপনাকে প্রথমে একটি YAML ফাইল তৈরি করতে হবে যেখানে পড সিলেক্টর এবং ইনগ্রেস/ইগ্রেস নিয়মগুলো উল্লেখ থাকবে।

### Network Policy এর উদাহরণ:
   - উদাহরণস্বরূপ, একটি nginx ডিপ্লয়মেন্ট তৈরি করে এবং সেটিকে একটি সার্ভিসের মাধ্যমে এক্সপোজ করে, আপনি দেখতে পারেন কীভাবে Network Policy কাজ করে।

### Network Policy কেনো ব্যবহার করবো?
1. **নিরাপত্তা:** Network Policy ব্যবহার করে আপনি নির্দিষ্ট করতে পারেন কোন পড বা সার্ভিস একে অপরের সাথে যোগাযোগ করতে পারবে এবং কোন ট্রাফিক ব্লক করা উচিত। এটি অননুমোদিত অ্যাক্সেস প্রতিরোধ করতে সাহায্য করে।
2. **কমপ্লায়েন্স:** কিছু ইন্ডাস্ট্রিতে (যেমন স্বাস্থ্যসেবা বা আর্থিক সেবা) কমপ্লায়েন্স রিকোয়ারমেন্ট থাকে যা Network Policy ব্যবহার করে পূরণ করা যায়।
3. **ট্রাফিক নিয়ন্ত্রণ:** Network Policy ব্যবহার করে আপনি ক্লাস্টারের মধ্যে ট্রাফিক প্রবাহ নিয়ন্ত্রণ করতে পারেন, যা ক্লাস্টারের পারফরম্যান্স এবং নিরাপত্তা উন্নত করে। 

### Network Policy ব্যবহার না করলে কি হবে?
1. **নিরাপত্তা ঝুঁকি:** Network Policy ব্যবহার না করলে ক্লাস্টারের পডগুলোতে অননুমোদিত অ্যাক্সেস হতে পারে, যা নিরাপত্তা ঝুঁকি বাড়ায়।
2. **কমপ্লায়েন্স সমস্যা:** কিছু ইন্ডাস্ট্রিতে কমপ্লায়েন্স রিকোয়ারমেন্ট পূরণ করা কঠিন হতে পারে।
3. **ট্রাফিক নিয়ন্ত্রণের অভাব:** Network Policy ব্যবহার না করলে ক্লাস্টারের মধ্যে ট্রাফিক প্রবাহ নিয়ন্ত্রণ করা কঠিন হতে পারে, যা ক্লাস্টারের পারফরম্যান্স এবং নিরাপত্তা কমিয়ে দেয়।


আপনি যদি আরও বিস্তারিত জানতে চান, তাহলে [Kubernetes এর অফিসিয়াল ডকুমেন্টেশন](https://kubernetes.io/docs/concepts/services-networking/network-policies/) দেখতে পারেন।

Network Policy সম্পর্কে আরও কিছু গুরুত্বপূর্ণ বিষয় এখানে তুলে ধরা হলো:

1. **Namespace Isolation:**
   - Network Policy ব্যবহার করে আপনি নির্দিষ্ট নেমস্পেসের মধ্যে পডগুলোর মধ্যে যোগাযোগ সীমাবদ্ধ করতে পারেন। এটি মাল্টি-টেন্যান্ট ক্লাস্টারগুলোর জন্য বিশেষভাবে উপকারী।

2. **Default Deny Policy:**
   - আপনি একটি ডিফল্ট ডিনাই পলিসি কনফিগার করতে পারেন যা সমস্ত ইনগ্রেস এবং ইগ্রেস ট্রাফিক ব্লক করবে, এবং তারপর নির্দিষ্ট নিয়ম তৈরি করে অনুমতি দিতে পারেন।

3. **Policy Types:**
   - Network Policy দুই ধরনের হতে পারে: `Ingress` এবং `Egress`। আপনি একসাথে উভয় ধরনের পলিসি ব্যবহার করতে পারেন অথবা আলাদাভাবে ব্যবহার করতে পারেন।

4. **Label Selectors:**
   - লেবেল সিলেক্টর ব্যবহার করে আপনি নির্দিষ্ট লেবেলযুক্ত পডগুলোর জন্য পলিসি প্রয়োগ করতে পারেন। এটি আপনাকে আরও নির্দিষ্ট নিয়ম তৈরি করতে সাহায্য করে।

5. **Testing and Validation:**
   - Network Policy কনফিগার করার পর, আপনাকে নিশ্চিত করতে হবে যে পলিসিগুলো সঠিকভাবে কাজ করছে। এর জন্য আপনি `kubectl` কমান্ড ব্যবহার করে পডগুলোর মধ্যে ট্রাফিক পরীক্ষা করতে পারেন।
  
6. **Policy Order:**
   - Network Policy গুলো নির্দিষ্ট কোনো অর্ডারে প্রয়োগ হয় না। একাধিক পলিসি একই পডে প্রযোজ্য হলে, সমস্ত পলিসির সম্মিলিত প্রভাব কার্যকর হয়।

7. **Network Plugins:**
   - Network Policy কার্যকর করতে হলে আপনার ক্লাস্টারে একটি নেটওয়ার্ক প্লাগইন ইনস্টল থাকতে হবে যা Network Policy সমর্থন করে। যেমন: Calico, Cilium, বা Weave Net।

8. **Policy Scope:**
   - Network Policy শুধুমাত্র পড-টু-পড ট্রাফিক নিয়ন্ত্রণ করে। এটি নোড-টু-পড বা নোড-টু-নোড ট্রাফিক নিয়ন্ত্রণ করে না।

9. **Logging and Monitoring:**
   - Network Policy কনফিগার করার পর, আপনি লগিং এবং মনিটরিং টুল ব্যবহার করে ট্রাফিকের উপর নজর রাখতে পারেন। এটি আপনাকে পলিসির কার্যকারিতা যাচাই করতে সাহায্য করবে।

10. **Advanced Use Cases:**
   - আপনি Network Policy ব্যবহার করে আরও জটিল নিয়ম তৈরি করতে পারেন, যেমন নির্দিষ্ট পোর্ট বা প্রোটোকল ভিত্তিক নিয়ম, নির্দিষ্ট IP ব্লক করা ইত্যাদি।

### Network Policy উদাহরণ:
```
nano simple-netpol.yaml
```

```
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-frontend-to-backend
  namespace: default
spec:
  podSelector:
    matchLabels:
      app: backend
  ingress:
  - from:
    - podSelector:
        matchLabels:
          app: frontend
    ports:
    - protocol: TCP
      port: 80
```
এই Network Policy টি backend লেবেলযুক্ত পডগুলিতে শুধুমাত্র frontend লেবেলযুক্ত পডগুলি থেকে TCP পোর্ট 80 এ ট্রাফিক অনুমতি দেয়।

```
kubectl apply -f simple-netpol.yaml
```

### উদাহরণ ১: সমস্ত ইনগ্রেস ট্রাফিক ব্লক করা

**গল্প:**
আপনার একটি ক্লাস্টার আছে যেখানে বিভিন্ন অ্যাপ্লিকেশন চলছে। আপনি চান যে কোনো পডে বাইরের কোনো ট্রাফিক প্রবেশ করতে না পারে। এজন্য আপনি একটি Network Policy তৈরি করবেন যা সমস্ত ইনগ্রেস ট্রাফিক ব্লক করবে।

```
nano netpol-exam-1.yaml
```

**YAML কোড:**
```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: deny-all-ingress
  namespace: default
spec:
  podSelector: {}
  policyTypes:
  - Ingress
```

**বর্ণনা:**
- `podSelector`: সমস্ত পডে এই পলিসি প্রযোজ্য হবে।
- `policyTypes`: `Ingress` নির্ধারণ করা হয়েছে, যা ইনগ্রেস ট্রাফিক নিয়ন্ত্রণ করবে।
- এই পলিসি সমস্ত ইনগ্রেস ট্রাফিক ব্লক করবে।

```
kubectl apply -f netpol-exam-1.yaml
```

### উদাহরণ ২: নির্দিষ্ট পডে ইনগ্রেস ট্রাফিক অনুমতি দেওয়া

**গল্প:**
আপনার একটি অ্যাপ্লিকেশন আছে যার নাম `myapp`। আপনি চান যে শুধুমাত্র `myapp` লেবেলযুক্ত পডগুলোতে ইনগ্রেস ট্রাফিক প্রবেশ করতে পারে। এজন্য আপনি একটি Network Policy তৈরি করবেন যা নির্দিষ্ট লেবেলযুক্ত পডে ইনগ্রেস ট্রাফিক অনুমতি দেবে।

```
nano netpol-exam-2.yaml
```

**YAML কোড:**
```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-ingress-to-specific-pod
  namespace: default
spec:
  podSelector:
    matchLabels:
      app: myapp
  policyTypes:
  - Ingress
  ingress:
  - from:
    - podSelector:
        matchLabels:
          app: myapp
```

**বর্ণনা:**
- `podSelector`: `app: myapp` লেবেলযুক্ত পডগুলোতে এই পলিসি প্রযোজ্য হবে।
- `policyTypes`: `Ingress` নির্ধারণ করা হয়েছে, যা ইনগ্রেস ট্রাফিক নিয়ন্ত্রণ করবে।
- `ingress`: নির্দিষ্ট পড থেকে ইনগ্রেস ট্রাফিক অনুমতি দেবে।

```
kubectl apply -f netpol-exam-2.yaml
```

### উদাহরণ ৩: নির্দিষ্ট পোর্টে ইনগ্রেস ট্রাফিক অনুমতি দেওয়া

**গল্প:**
আপনার একটি ওয়েব সার্ভার আছে যা ৮০ পোর্টে চলে। আপনি চান যে শুধুমাত্র ৮০ পোর্টে ইনগ্রেস ট্রাফিক প্রবেশ করতে পারে। এজন্য আপনি একটি Network Policy তৈরি করবেন যা নির্দিষ্ট পোর্টে ইনগ্রেস ট্রাফিক অনুমতি দেবে।

```
nano netpol-exam-3.yaml
```

**YAML কোড:**
```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-ingress-to-port
  namespace: default
spec:
  podSelector:
    matchLabels:
      app: myapp
  policyTypes:
  - Ingress
  ingress:
  - from:
    - podSelector:
        matchLabels:
          app: myapp
    ports:
    - protocol: TCP
      port: 80
```

**বর্ণনা:**
- `podSelector`: `app: myapp` লেবেলযুক্ত পডগুলোতে এই পলিসি প্রযোজ্য হবে।
- `policyTypes`: `Ingress` নির্ধারণ করা হয়েছে, যা ইনগ্রেস ট্রাফিক নিয়ন্ত্রণ করবে।
- `ingress`: নির্দিষ্ট পড থেকে নির্দিষ্ট পোর্টে (TCP 80) ইনগ্রেস ট্রাফিক অনুমতি দেবে।

```
kubectl apply -f netpol-exam-3.yaml
```

### উদাহরণ ৪: সমস্ত ইগ্রেস ট্রাফিক ব্লক করা

**গল্প:**
আপনার একটি ক্লাস্টার আছে যেখানে আপনি চান যে কোনো পড থেকে বাইরের কোনো ট্রাফিক বের হতে না পারে। এজন্য আপনি একটি Network Policy তৈরি করবেন যা সমস্ত ইগ্রেস ট্রাফিক ব্লক করবে।

```
nano netpol-exam-4.yaml
```

**YAML কোড:**
```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: deny-all-egress
  namespace: default
spec:
  podSelector: {}
  policyTypes:
  - Egress
```

**বর্ণনা:**
- `podSelector`: সমস্ত পডে এই পলিসি প্রযোজ্য হবে।
- `policyTypes`: `Egress` নির্ধারণ করা হয়েছে, যা ইগ্রেস ট্রাফিক নিয়ন্ত্রণ করবে।
- এই পলিসি সমস্ত ইগ্রেস ট্রাফিক ব্লক করবে।

```
kubectl apply -f netpol-exam-4.yaml
```

### উদাহরণ ৫: নির্দিষ্ট নেমস্পেস থেকে ইনগ্রেস ট্রাফিক অনুমতি দেওয়া

**গল্প:**
আপনার একটি প্রজেক্ট আছে যার নাম `myproject`। আপনি চান যে শুধুমাত্র `myproject` নেমস্পেস থেকে ইনগ্রেস ট্রাফিক প্রবেশ করতে পারে। এজন্য আপনি একটি Network Policy তৈরি করবেন যা নির্দিষ্ট নেমস্পেস থেকে ইনগ্রেস ট্রাফিক অনুমতি দেবে।

```
nano netpol-exam-5.yaml
```

**YAML কোড:**
```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-ingress-from-namespace
  namespace: default
spec:
  podSelector:
    matchLabels:
      app: myapp
  policyTypes:
  - Ingress
  ingress:
  - from:
    - namespaceSelector:
        matchLabels:
          project: myproject
```

**বর্ণনা:**
- `podSelector`: `app: myapp` লেবেলযুক্ত পডগুলোতে এই পলিসি প্রযোজ্য হবে।
- `policyTypes`: `Ingress` নির্ধারণ করা হয়েছে, যা ইনগ্রেস ট্রাফিক নিয়ন্ত্রণ করবে।
- `ingress`: `project: myproject` লেবেলযুক্ত নেমস্পেস থেকে ইনগ্রেস ট্রাফিক অনুমতি দেবে।

```
kubectl apply -f netpol-exam-5.yaml
```

### উদাহরণ ৬: নির্দিষ্ট পডে ইনগ্রেস এবং ইগ্রেস ট্রাফিক নিয়ন্ত্রণ করা

**গল্প:**
আপনার একটি অ্যাপ্লিকেশন আছে যার নাম `myapp`। আপনি চান যে শুধুমাত্র `myapp` লেবেলযুক্ত পডগুলোতে ইনগ্রেস এবং ইগ্রেস ট্রাফিক নিয়ন্ত্রণ করা হোক। এজন্য আপনি একটি Network Policy তৈরি করবেন যা নির্দিষ্ট লেবেলযুক্ত পডে ইনগ্রেস এবং ইগ্রেস ট্রাফিক নিয়ন্ত্রণ করবে।

```
nano netpol-exam-6.yaml
```

**YAML কোড:**
```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: control-ingress-egress
  namespace: default
spec:
  podSelector:
    matchLabels:
      app: myapp
  policyTypes:
  - Ingress
  - Egress
  ingress:
  - from:
    - podSelector:
        matchLabels:
          app: myapp
  egress:
  - to:
    - podSelector:
        matchLabels:
          app: myapp
```

**বর্ণনা:**
- `podSelector`: `app: myapp` লেবেলযুক্ত পডগুলোতে এই পলিসি প্রযোজ্য হবে।
- `policyTypes`: `Ingress` এবং `Egress` উভয়ই নির্ধারণ করা হয়েছে, যা ইনগ্রেস এবং ইগ্রেস ট্রাফিক নিয়ন্ত্রণ করবে।
- `ingress`: `app: myapp` লেবেলযুক্ত পড থেকে ইনগ্রেস ট্রাফিক অনুমতি দেবে।
- `egress`: `app: myapp` লেবেলযুক্ত পডে ইগ্রেস ট্রাফিক অনুমতি দেবে।

```
kubectl apply -f netpol-exam-6.yaml
```

### উদাহরণ ৭: নির্দিষ্ট IP ব্লকে ইগ্রেস ট্রাফিক ব্লক করা

**গল্প:**
আপনার একটি ক্লাস্টার আছে যেখানে আপনি চান যে কোনো পড থেকে নির্দিষ্ট IP ব্লকে ট্রাফিক বের হতে না পারে। উদাহরণস্বরূপ, আপনি চান যে 10.0.0.0/24 IP ব্লকে কোনো ট্রাফিক না যাক। এজন্য আপনি একটি Network Policy তৈরি করবেন যা নির্দিষ্ট IP ব্লকে ইগ্রেস ট্রাফিক ব্লক করবে।

```
nano netpol-exam-7.yaml
```

**YAML কোড:**
```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: deny-egress-to-ip-block
  namespace: default
spec:
  podSelector:
    matchLabels:
      app: myapp
  policyTypes:
  - Egress
  egress:
  - to:
    - ipBlock:
        cidr: 10.0.0.0/24
```

**বর্ণনা:**
- `podSelector`: `app: myapp` লেবেলযুক্ত পডগুলোতে এই পলিসি প্রযোজ্য হবে।
- `policyTypes`: `Egress` নির্ধারণ করা হয়েছে, যা ইগ্রেস ট্রাফিক নিয়ন্ত্রণ করবে।
- `egress`: 10.0.0.0/24 IP ব্লকে ইগ্রেস ট্রাফিক ব্লক করবে।

```
kubectl apply -f netpol-exam-3.yaml
```

### উদাহরণ ৮: নির্দিষ্ট নেমস্পেস থেকে ইনগ্রেস ট্রাফিক অনুমতি দেওয়া

**গল্প:**
আপনার একটি প্রজেক্ট আছে যার নাম `myproject`। আপনি চান যে শুধুমাত্র `myproject` নেমস্পেস থেকে ইনগ্রেস ট্রাফিক প্রবেশ করতে পারে। এজন্য আপনি একটি Network Policy তৈরি করবেন যা নির্দিষ্ট নেমস্পেস থেকে ইনগ্রেস ট্রাফিক অনুমতি দেবে।

```
nano netpol-exam-8.yaml
```

**YAML কোড:**
```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-ingress-from-namespace
  namespace: default
spec:
  podSelector:
    matchLabels:
      app: myapp
  policyTypes:
  - Ingress
  ingress:
  - from:
    - namespaceSelector:
        matchLabels:
          project: myproject
```

**বর্ণনা:**
- `podSelector`: `app: myapp` লেবেলযুক্ত পডগুলোতে এই পলিসি প্রযোজ্য হবে।
- `policyTypes`: `Ingress` নির্ধারণ করা হয়েছে, যা ইনগ্রেস ট্রাফিক নিয়ন্ত্রণ করবে।
- `ingress`: `project: myproject` লেবেলযুক্ত নেমস্পেস থেকে ইনগ্রেস ট্রাফিক অনুমতি দেবে।

```
kubectl apply -f netpol-exam-8.yaml
```

### উদাহরণ ৯: নির্দিষ্ট পডে ইনগ্রেস এবং ইগ্রেস ট্রাফিক নিয়ন্ত্রণ করা

**গল্প:**
আপনার একটি অ্যাপ্লিকেশন আছে যার নাম `myapp`। আপনি চান যে শুধুমাত্র `myapp` লেবেলযুক্ত পডগুলোতে ইনগ্রেস এবং ইগ্রেস ট্রাফিক নিয়ন্ত্রণ করা হোক। এজন্য আপনি একটি Network Policy তৈরি করবেন যা নির্দিষ্ট লেবেলযুক্ত পডে ইনগ্রেস এবং ইগ্রেস ট্রাফিক নিয়ন্ত্রণ করবে।

```
nano netpol-exam-9.yaml
```

**YAML কোড:**
```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: control-ingress-egress
  namespace: default
spec:
  podSelector:
    matchLabels:
      app: myapp
  policyTypes:
  - Ingress
  - Egress
  ingress:
  - from:
    - podSelector:
        matchLabels:
          app: myapp
  egress:
  - to:
    - podSelector:
        matchLabels:
          app: myapp
```

**বর্ণনা:**
- `podSelector`: `app: myapp` লেবেলযুক্ত পডগুলোতে এই পলিসি প্রযোজ্য হবে।
- `policyTypes`: `Ingress` এবং `Egress` উভয়ই নির্ধারণ করা হয়েছে, যা ইনগ্রেস এবং ইগ্রেস ট্রাফিক নিয়ন্ত্রণ করবে।
- `ingress`: `app: myapp` লেবেলযুক্ত পড থেকে ইনগ্রেস ট্রাফিক অনুমতি দেবে।
- `egress`: `app: myapp` লেবেলযুক্ত পডে ইগ্রেস ট্রাফিক অনুমতি দেবে।

```
kubectl apply -f netpol-exam-9.yaml
```

### উদাহরণ ১০: নির্দিষ্ট পোর্টে ইগ্রেস ট্রাফিক অনুমতি দেওয়া

**গল্প:**
আপনার একটি অ্যাপ্লিকেশন আছে যা নির্দিষ্ট পোর্টে বাইরের সার্ভিসের সাথে যোগাযোগ করে। উদাহরণস্বরূপ, আপনার অ্যাপ্লিকেশন HTTPS (443 পোর্ট) ব্যবহার করে বাইরের সার্ভিসের সাথে যোগাযোগ করে। এজন্য আপনি একটি Network Policy তৈরি করবেন যা নির্দিষ্ট পোর্টে ইগ্রেস ট্রাফিক অনুমতি দেবে।

```
nano netpol-exam-10.yaml
```

**YAML কোড:**
```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-egress-to-port
  namespace: default
spec:
  podSelector:
    matchLabels:
      app: myapp
  policyTypes:
  - Egress
  egress:
  - to:
    - podSelector:
        matchLabels:
          app: myapp
    ports:
    - protocol: TCP
      port: 443
```

**বর্ণনা:**
- `podSelector`: `app: myapp` লেবেলযুক্ত পডগুলোতে এই পলিসি প্রযোজ্য হবে।
- `policyTypes`: `Egress` নির্ধারণ করা হয়েছে, যা ইগ্রেস ট্রাফিক নিয়ন্ত্রণ করবে।
- `egress`: নির্দিষ্ট পড থেকে নির্দিষ্ট পোর্টে (TCP 443) ইগ্রেস ট্রাফিক অনুমতি দেবে।

```
kubectl apply -f netpol-exam-10.yaml
```

### উদাহরণ ১১: নির্দিষ্ট IP ব্লকে ইনগ্রেস ট্রাফিক অনুমতি দেওয়া

**গল্প:**
আপনার একটি ক্লাস্টার আছে যেখানে আপনি চান যে নির্দিষ্ট IP ব্লক থেকে ইনগ্রেস ট্রাফিক প্রবেশ করতে পারে। উদাহরণস্বরূপ, আপনি চান যে 192.168.1.0/24 IP ব্লক থেকে ইনগ্রেস ট্রাফিক অনুমতি দেওয়া হোক। এজন্য আপনি একটি Network Policy তৈরি করবেন যা নির্দিষ্ট IP ব্লকে ইনগ্রেস ট্রাফিক অনুমতি দেবে।

```
nano netpol-exam-11.yaml
```

**YAML কোড:**
```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-ingress-from-ip-block
  namespace: default
spec:
  podSelector:
    matchLabels:
      app: myapp
  policyTypes:
  - Ingress
  ingress:
  - from:
    - ipBlock:
        cidr: 192.168.1.0/24
        except:
        - 192.168.1.5/32
```

**বর্ণনা:**
- `podSelector`: `app: myapp` লেবেলযুক্ত পডগুলোতে এই পলিসি প্রযোজ্য হবে।
- `policyTypes`: `Ingress` নির্ধারণ করা হয়েছে, যা ইনগ্রেস ট্রাফিক নিয়ন্ত্রণ করবে।
- `ingress`: 192.168.1.0/24 IP ব্লক থেকে ইনগ্রেস ট্রাফিক অনুমতি দেবে, তবে 192.168.1.5 IP ঠিকানা ব্যতীত।

```
kubectl apply -f netpol-exam-11.yaml
```

### উদাহরণ ১২: নির্দিষ্ট পডে শুধুমাত্র নির্দিষ্ট পোর্টে ইনগ্রেস ট্রাফিক অনুমতি দেওয়া

**গল্প:**
আপনার একটি ওয়েব সার্ভার আছে যা ৮০ পোর্টে চলে। আপনি চান যে শুধুমাত্র ৮০ পোর্টে ইনগ্রেস ট্রাফিক প্রবেশ করতে পারে। এজন্য আপনি একটি Network Policy তৈরি করবেন যা নির্দিষ্ট পোর্টে ইনগ্রেস ট্রাফিক অনুমতি দেবে।

```
nano netpol-exam-12.yaml
```

**YAML কোড:**
```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-specific-port-ingress
  namespace: default
spec:
  podSelector:
    matchLabels:
      app: myapp
  policyTypes:
  - Ingress
  ingress:
  - from:
    - podSelector:
        matchLabels:
          app: myapp
    ports:
    - protocol: TCP
      port: 8080
```

**বর্ণনা:**
- `podSelector`: `app: myapp` লেবেলযুক্ত পডগুলোতে এই পলিসি প্রযোজ্য হবে।
- `policyTypes`: `Ingress` নির্ধারণ করা হয়েছে, যা ইনগ্রেস ট্রাফিক নিয়ন্ত্রণ করবে।
- `ingress`: নির্দিষ্ট পড থেকে নির্দিষ্ট পোর্টে (TCP 8080) ইনগ্রেস ট্রাফিক অনুমতি দেবে।

```
kubectl apply -f netpol-exam-12.yaml
```

### উদাহরণ ১৩: নির্দিষ্ট পডে নির্দিষ্ট পোর্টে ইনগ্রেস এবং ইগ্রেস ট্রাফিক নিয়ন্ত্রণ করা

**গল্প:**
আপনার একটি অ্যাপ্লিকেশন আছে যার নাম `myapp`। আপনি চান যে শুধুমাত্র `myapp` লেবেলযুক্ত পডগুলোতে নির্দিষ্ট পোর্টে ইনগ্রেস এবং ইগ্রেস ট্রাফিক নিয়ন্ত্রণ করা হোক। উদাহরণস্বরূপ, আপনি চান যে ৮০ পোর্টে ইনগ্রেস এবং ৪৪৩ পোর্টে ইগ্রেস ট্রাফিক অনুমতি দেওয়া হোক।

```
nano netpol-exam-13.yaml
```

**YAML কোড:**
```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: control-specific-port-ingress-egress
  namespace: default
spec:
  podSelector:
    matchLabels:
      app: myapp
  policyTypes:
  - Ingress
  - Egress
  ingress:
  - from:
    - podSelector:
        matchLabels:
          app: myapp
    ports:
    - protocol: TCP
      port: 80
  egress:
  - to:
    - podSelector:
        matchLabels:
          app: myapp
    ports:
    - protocol: TCP
      port: 443
```

**বর্ণনা:**
- `podSelector`: `app: myapp` লেবেলযুক্ত পডগুলোতে এই পলিসি প্রযোজ্য হবে।
- `policyTypes`: `Ingress` এবং `Egress` উভয়ই নির্ধারণ করা হয়েছে, যা ইনগ্রেস এবং ইগ্রেস ট্রাফিক নিয়ন্ত্রণ করবে।
- `ingress`: নির্দিষ্ট পড থেকে নির্দিষ্ট পোর্টে (TCP 80) ইনগ্রেস ট্রাফিক অনুমতি দেবে।
- `egress`: নির্দিষ্ট পড থেকে নির্দিষ্ট পোর্টে (TCP 443) ইগ্রেস ট্রাফিক অনুমতি দেবে।

```
kubectl apply -f netpol-exam-13.yaml
```

### উদাহরণ ১৪: নির্দিষ্ট পডে নির্দিষ্ট প্রোটোকল ভিত্তিক নিয়ম

**গল্প:**
আপনার একটি অ্যাপ্লিকেশন আছে যার নাম `myapp`। আপনি চান যে শুধুমাত্র `myapp` লেবেলযুক্ত পডগুলোতে নির্দিষ্ট প্রোটোকল ভিত্তিক নিয়ম প্রযোজ্য হোক। উদাহরণস্বরূপ, আপনি চান যে শুধুমাত্র UDP প্রোটোকল ব্যবহার করে ইনগ্রেস এবং ইগ্রেস ট্রাফিক অনুমতি দেওয়া হোক।

```
nano netpol-exam-14.yaml
```

**YAML কোড:**
```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: control-protocol-ingress-egress
  namespace: default
spec:
  podSelector:
    matchLabels:
      app: myapp
  policyTypes:
  - Ingress
  - Egress
  ingress:
  - from:
    - podSelector:
        matchLabels:
          app: myapp
    ports:
    - protocol: UDP
      port: 53
  egress:
  - to:
    - podSelector:
        matchLabels:
          app: myapp
    ports:
    - protocol: UDP
      port: 53
```

**বর্ণনা:**
- `podSelector`: `app: myapp` লেবেলযুক্ত পডগুলোতে এই পলিসি প্রযোজ্য হবে।
- `policyTypes`: `Ingress` এবং `Egress` উভয়ই নির্ধারণ করা হয়েছে, যা ইনগ্রেস এবং ইগ্রেস ট্রাফিক নিয়ন্ত্রণ করবে।
- `ingress`: নির্দিষ্ট পড থেকে নির্দিষ্ট প্রোটোকল (UDP 53) ব্যবহার করে ইনগ্রেস ট্রাফিক অনুমতি দেবে।
- `egress`: নির্দিষ্ট পড থেকে নির্দিষ্ট প্রোটোকল (UDP 53) ব্যবহার করে ইগ্রেস ট্রাফিক অনুমতি দেবে।

```
kubectl apply -f netpol-exam-14.yaml
```

### উদাহরণ ১৫: নির্দিষ্ট সময়ের জন্য ট্রাফিক নিয়ন্ত্রণ

**গল্প:**
আপনার একটি অ্যাপ্লিকেশন আছে যার নাম `myapp`। আপনি চান যে নির্দিষ্ট সময়ের জন্য ট্রাফিক নিয়ন্ত্রণ করা হোক। উদাহরণস্বরূপ, আপনি চান যে রাত ১০টা থেকে সকাল ৬টা পর্যন্ত ইনগ্রেস এবং ইগ্রেস ট্রাফিক ব্লক করা হোক।

```
nano netpol-exam-15.yaml
```

**YAML কোড:**
```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: time-based-traffic-control
  namespace: default
spec:
  podSelector:
    matchLabels:
      app: myapp
  policyTypes:
  - Ingress
  - Egress
  ingress:
  - from:
    - podSelector:
        matchLabels:
          app: myapp
    ports:
    - protocol: TCP
      port: 80
  egress:
  - to:
    - podSelector:
        matchLabels:
          app: myapp
    ports:
    - protocol: TCP
      port: 443
  - to:
    - ipBlock:
        cidr: 0.0.0.0/0
        except:
        - 192.168.1.0/24
```

**বর্ণনা:**
- `podSelector`: `app: myapp` লেবেলযুক্ত পডগুলোতে এই পলিসি প্রযোজ্য হবে।
- `policyTypes`: `Ingress` এবং `Egress` উভয়ই নির্ধারণ করা হয়েছে, যা ইনগ্রেস এবং ইগ্রেস ট্রাফিক নিয়ন্ত্রণ করবে।
- `ingress`: নির্দিষ্ট পড থেকে নির্দিষ্ট পোর্টে (TCP 80) ইনগ্রেস ট্রাফিক অনুমতি দেবে।
- `egress`: নির্দিষ্ট পড থেকে নির্দিষ্ট পোর্টে (TCP 443) ইগ্রেস ট্রাফিক অনুমতি দেবে এবং নির্দিষ্ট IP ব্লক ব্যতীত সমস্ত IP ব্লকে ইগ্রেস ট্রাফিক ব্লক করবে।

```
kubectl apply -f netpol-exam-15.yaml
```

### উদাহরণ ১৬: নির্দিষ্ট পডে নির্দিষ্ট সময়ের জন্য ইনগ্রেস এবং ইগ্রেস ট্রাফিক নিয়ন্ত্রণ

**গল্প:**
আপনার একটি অ্যাপ্লিকেশন আছে যার নাম `myapp`। আপনি চান যে নির্দিষ্ট সময়ের জন্য ইনগ্রেস এবং ইগ্রেস ট্রাফিক নিয়ন্ত্রণ করা হোক। উদাহরণস্বরূপ, আপনি চান যে রাত ১০টা থেকে সকাল ৬টা পর্যন্ত ইনগ্রেস এবং ইগ্রেস ট্রাফিক ব্লক করা হোক।

```
nano netpol-exam-16.yaml
```

**YAML কোড:**
```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: time-based-ingress-egress-control
  namespace: default
spec:
  podSelector:
    matchLabels:
      app: myapp
  policyTypes:
  - Ingress
  - Egress
  ingress:
  - from:
    - podSelector:
        matchLabels:
          app: myapp
    ports:
    - protocol: TCP
      port: 80
  egress:
  - to:
    - podSelector:
        matchLabels:
          app: myapp
    ports:
    - protocol: TCP
      port: 443
  - to:
    - ipBlock:
        cidr: 0.0.0.0/0
        except:
        - 192.168.1.0/24
```

**বর্ণনা:**
- `podSelector`: `app: myapp` লেবেলযুক্ত পডগুলোতে এই পলিসি প্রযোজ্য হবে।
- `policyTypes`: `Ingress` এবং `Egress` উভয়ই নির্ধারণ করা হয়েছে, যা ইনগ্রেস এবং ইগ্রেস ট্রাফিক নিয়ন্ত্রণ করবে।
- `ingress`: নির্দিষ্ট পড থেকে নির্দিষ্ট পোর্টে (TCP 80) ইনগ্রেস ট্রাফিক অনুমতি দেবে।
- `egress`: নির্দিষ্ট পড থেকে নির্দিষ্ট পোর্টে (TCP 443) ইগ্রেস ট্রাফিক অনুমতি দেবে এবং নির্দিষ্ট IP ব্লক ব্যতীত সমস্ত IP ব্লকে ইগ্রেস ট্রাফিক ব্লক করবে।

```
kubectl apply -f netpol-exam-16.yaml
```

### কাস্টম স্ক্রিপ্ট ব্যবহার করে Network Policy তৈরি করা

কাস্টম স্ক্রিপ্ট ব্যবহার করে Network Policy তৈরি করা একটি কার্যকর উপায় যা আপনাকে স্বয়ংক্রিয়ভাবে বিভিন্ন নেমস্পেস এবং পডের জন্য Network Policy প্রয়োগ করতে সাহায্য করে। এখানে কয়েকটি ধাপে ধাপে বাস্তবভিত্তিক উদাহরণ এবং কাস্টম স্ক্রিপ্টের বর্ণনা দেওয়া হলো:

### উদাহরণ ১: সমস্ত নেমস্পেসের জন্য ইনগ্রেস ট্রাফিক ব্লক করা

**গল্প:**
আপনার একটি বড় ক্লাস্টার আছে যেখানে বিভিন্ন নেমস্পেসে অনেক পড চলছে। আপনি চান যে সমস্ত নেমস্পেসের জন্য ইনগ্রেস ট্রাফিক ব্লক করা হোক। এজন্য আপনি একটি কাস্টম স্ক্রিপ্ট ব্যবহার করতে পারেন।

```
nano netpol-all-ns.sh
```

**স্ক্রিপ্ট:**
```bash
#!/bin/bash
for namespace in $(kubectl get namespaces -o jsonpath='{.items[*].metadata.name}'); do
  cat <<EOF | kubectl apply -f -
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: deny-all-ingress
  namespace: $namespace
spec:
  podSelector: {}
  policyTypes:
  - Ingress
EOF
done
```

**বর্ণনা:**
- এই স্ক্রিপ্টটি সমস্ত নেমস্পেসের জন্য একটি Network Policy তৈরি করে যা সমস্ত ইনগ্রেস ট্রাফিক ব্লক করবে।
- `kubectl get namespaces -o jsonpath='{.items[*].metadata.name}'` কমান্ডটি সমস্ত নেমস্পেসের নাম সংগ্রহ করে।
- `cat <<EOF | kubectl apply -f -` কমান্ডটি YAML ফাইল তৈরি করে এবং তা প্রয়োগ করে।

```
. custom-netpol-all-ns.sh
```

### উদাহরণ ২: নির্দিষ্ট লেবেলযুক্ত পডের জন্য ইনগ্রেস এবং ইগ্রেস ট্রাফিক নিয়ন্ত্রণ করা

**গল্প:**
আপনার একটি অ্যাপ্লিকেশন আছে যার নাম `myapp`। আপনি চান যে শুধুমাত্র `myapp` লেবেলযুক্ত পডগুলোর জন্য ইনগ্রেস এবং ইগ্রেস ট্রাফিক নিয়ন্ত্রণ করা হোক। এজন্য আপনি একটি কাস্টম স্ক্রিপ্ট ব্যবহার করতে পারেন।

```
nano netpol-fix-label.sh
```

**স্ক্রিপ্ট:**
```bash
#!/bin/bash
for namespace in $(kubectl get namespaces -o jsonpath='{.items[*].metadata.name}'); do
  cat <<EOF | kubectl apply -f -
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: control-ingress-egress
  namespace: $namespace
spec:
  podSelector:
    matchLabels:
      app: myapp
  policyTypes:
  - Ingress
  - Egress
  ingress:
  - from:
    - podSelector:
        matchLabels:
          app: myapp
  egress:
  - to:
    - podSelector:
        matchLabels:
          app: myapp
EOF
done
```

**বর্ণনা:**
- এই স্ক্রিপ্টটি সমস্ত নেমস্পেসের জন্য একটি Network Policy তৈরি করে যা `myapp` লেবেলযুক্ত পডগুলোর জন্য ইনগ্রেস এবং ইগ্রেস ট্রাফিক নিয়ন্ত্রণ করবে।
- `podSelector` ব্যবহার করে নির্দিষ্ট লেবেলযুক্ত পডগুলো নির্বাচন করা হয়েছে।
- `policyTypes` এ `Ingress` এবং `Egress` উভয়ই নির্ধারণ করা হয়েছে।

```
. netpol-fix-label.sh
```

### উদাহরণ ৩: নির্দিষ্ট IP ব্লকে ইগ্রেস ট্রাফিক ব্লক করা

**গল্প:**
আপনার একটি ক্লাস্টার আছে যেখানে আপনি চান যে কোনো পড থেকে নির্দিষ্ট IP ব্লকে ট্রাফিক বের হতে না পারে। উদাহরণস্বরূপ, আপনি চান যে 10.0.0.0/24 IP ব্লকে কোনো ট্রাফিক না যাক। এজন্য আপনি একটি কাস্টম স্ক্রিপ্ট ব্যবহার করতে পারেন।

```
nano netpol-fix-ip.sh
```

**স্ক্রিপ্ট:**
```bash
#!/bin/bash
for namespace in $(kubectl get namespaces -o jsonpath='{.items[*].metadata.name}'); do
  cat <<EOF | kubectl apply -f -
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: deny-egress-to-ip-block
  namespace: $namespace
spec:
  podSelector: {}
  policyTypes:
  - Egress
  egress:
  - to:
    - ipBlock:
        cidr: 10.0.0.0/24
EOF
done
```

**বর্ণনা:**
- এই স্ক্রিপ্টটি সমস্ত নেমস্পেসের জন্য একটি Network Policy তৈরি করে যা 10.0.0.0/24 IP ব্লকে ইগ্রেস ট্রাফিক ব্লক করবে।
- `ipBlock` ব্যবহার করে নির্দিষ্ট IP ব্লক নির্বাচন করা হয়েছে।
- `policyTypes` এ `Egress` নির্ধারণ করা হয়েছে।

```
. netpol-fix-ip.sh
```
