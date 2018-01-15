######################
# K8s certificates
######################

# Generate CA certificate
resource "null_resource" "ca-certificate" {
  depends_on = ["aws_elb.kubernetes_api","aws_instance.etcd","aws_instance.controller","aws_instance.worker"]

  provisioner "local-exec" {
    command = "cd ../certs; cfssl gencert -initca ca-csr.json | cfssljson -bare ca"
  }
}

# Generate Admin Client Certificate
resource "null_resource" "admin-certificate" {
  depends_on = ["null_resource.ca-certificate"]

  provisioner "local-exec" {
    command = "cd ../certs; cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json -profile=kubernetes admin-csr.json | cfssljson -bare admin"
    }
}

# Generate kube-proxy Client Certificate
resource "null_resource" "kube-proxy-certificate" {
  depends_on = ["null_resource.ca-certificate"]

  provisioner "local-exec" {
    command = "cd ../certs; cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json -profile=kubernetes kube-proxy-csr.json | cfssljson -bare kube-proxy"
    }
}
