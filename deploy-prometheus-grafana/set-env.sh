#Helps to address error: x509: certificate signed by unknown authority
launch.sh
curl -LO https://letsencrypt.org/certs/lets-encrypt-x3-cross-signed.pem > /dev/null 2>&1
oc login -u developer -p developer https://master:8443 --certificate-authority=lets-encrypt-x3-cross-signed.pem --insecure-skip-tls-verify=true > /dev/null 2>&1
oc new-project metrics-demo
oc new-app quay.io/4n4nd/metrics-demo-app:workshop
oc expose svc/metrics-demo-app
clear

echo -e "Welcome to your interactive environment. OpenShift is configured and ready to use."
