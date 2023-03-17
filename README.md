# Bucky

Private nginx webserver serving content from GCS (gcsfuse) or S3 (s3fs-fuse). Bucky connects nginx containers with private buckets 

> Note: the project was inspired by [k8s-storage-buckets](https://github.com/ageapps/k8s-storage-buckets)

## How to deploy bucky in GKE(Google Kubernetes Engine)?

You will need the following components:

- Deployment
- Service
- Ingress
- Service account
- `gcs` bucket

```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: bucky
  namespace: bucky
spec:
  replicas: 1
  selector:
    matchLabels:
      app: bucky
  template:
    metadata:
      labels:
        app: bucky
    spec:
      serviceAccount: bucky
      volumes:
        - name: nginx-content
          emptyDir: {}  
      containers:
      - name: "nginx"
        image: multilayerlabs/bucky:gcsfuse-latest
        securityContext:
          privileged: true
          capabilities:
            add:
              - SYS_ADMIN
        ports:
          - name: http
            containerPort: 8080
        lifecycle:
            preStop:
              exec:
                command: ["/usr/sbin/nginx","-s","quit","&&","fusermount", "-u", "/content"]
        env:
          - name: GCS_BUCKET_NAME
            value: ""
```
