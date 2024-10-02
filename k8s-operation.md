# Kubernets Operation


Create Pod from Local docker Image

    nano myhttpd.yaml
####
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
####
    kubectl apply -f myhttpd.yaml
####
    kubectl get pod
####
    kubectl port-forward myhttpd 8025:80 --address 0.0.0.0

