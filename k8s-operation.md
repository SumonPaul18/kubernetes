# Kubernets Operation
Check API Version of Kubernetes

    kubectl api-resources | grep pods

#

Create Pod with Local Image

    apiVersion: v1
    kind: Pod
    metadata:
      name: myhttpd
      labels:
        server: web
        app: www
    spec:
      containers:
        - name: myhttpd
          image: myhttpd
          imagePullPolicy: Never
          ports:
            - containerPort: 80