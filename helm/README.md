---
# HELM

### What is Helm?

Helm is often referred to as the package manager for Kubernetes. It enables you to define, install, and manage even the most complex Kubernetes applications. Helm uses a packaging format called charts, which include all the resources needed to run an application, service, or a complete cloud-native stack inside Kubernetes.

### Installing Helm
Section 1: Installation
```
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
```
[<b>Reference:</b> Helm Installation Guides From HELM Official Docs](https://helm.sh/docs/intro/install/) 


##### Important Helm Commands

- `helm create [CHART]`: Scaffold a new Helm chart.
- `helm package [CHART]`: Package the chart into a chart archive.
- `helm install [NAME] [CHART]`: Install a Helm chart.
- `helm upgrade [NAME] [CHART]`: Upgrade an installed Helm chart.
- `helm uninstall [NAME]`: Uninstall an installed Helm chart.
- `helm list`: List all installed Helm charts.
- `helm rollback [NAME] [REVISION]`: Roll back a release to a specific revision.

#### Section 2: Prerequisites

- Helm installed
- Kubernetes cluster set up (e.g., Minikube, kind, or any cloud-based Kubernetes)
- Docker installed (Optional for custom images)
- Basic understanding of Kubernetes resources like Pod, Service, Deployment

#### Section 3: Create Helm Chart Structure

Run the following command to scaffold a new Helm chart:

```bash
helm create node-app-chart
```

This will create a folder named `node-app-chart` with the initial chart structure.

#### Section 4: Chart Metadata (`Chart.yaml`)

Open `Chart.yaml` and modify it for your application:

```yaml
apiVersion: v2
name: node-app-chart
description: A Helm chart for a Node.js application
version: 0.1.0
```

#### Section 5: Default Values (`values.yaml`)

Edit `values.yaml` to include:

```yaml
replicaCount: 1

image:
  repository: sumonpaul/mynginx
  tag: latest
  pullPolicy: IfNotPresent

service:
  type: NodePort
  port: 30007
  targetPort: 8000
```

#### Section 6: Deployment Manifest (`templates/deployment.yaml`)

Modify `deployment.yaml` under `templates/` to look like this:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ .Release.Name }}-deployment
spec:
  replicas: {{ .Values.replicaCount }}
  selector:
    matchLabels:
      app: {{ .Release.Name }}
  template:
    metadata:
      labels:
        app: {{ .Release.Name }}
    spec:
      containers:
      - name: {{ .Chart.Name }}
        image: "{{ .Values.image.repository }}:{{ .Values.image.tag }}"
        imagePullPolicy: {{ .Values.image.pullPolicy }}
        ports:
        - containerPort: 8000
```

#### Section 7: Service Manifest (`templates/service.yaml`)

Open `service.yaml` under `templates/` and modify it:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: {{ .Release.Name }}-service
spec:
  type: {{ .Values.service.type }}
  ports:
  - port: {{ .Values.service.port }}
    targetPort: {{ .Values.service.targetPort }}
    nodePort: {{ .Values.service.port }}
  selector:
    app: {{ .Release.Name }}
```

#### Section 8: Deploying the Helm Chart

Use these commands to package and deploy the chart:

```bash
# Package the chart (Optional)
helm package node-app-chart

# Deploy the chart
helm install mynginx ./mynginx
```

#### Section 9: List the Deployment

```bash
# list the charts (Optional)
helm list

# Check the status
helm status <chart name>
```
