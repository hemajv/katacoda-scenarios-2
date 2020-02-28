launch.sh

git clone https://gitlab.com/opendatahub/opendatahub-operator.git
cd opendatahub-operator
git checkout v0.5.1

curl -LO https://letsencrypt.org/certs/lets-encrypt-x3-cross-signed.pem > /dev/null 2>&1
oc login -u developer -p developer --certificate-authority=lets-encrypt-x3-cross-signed.pem --insecure-skip-tls-verify=true > /dev/null 2>&1
oc new-project opendatahub

oc apply -f deploy/crds/opendatahub_v1alpha1_opendatahub_crd.yaml -n opendatahub --as system:admin
oc apply -f deploy/crds/seldon-deployment-crd.json -n opendatahub --as system:admin
oc apply -f deploy/crds/argo-crd.yaml -n opendatahub --as system:admin
oc apply -f deploy/service_account.yaml -n opendatahub --as system:admin
oc apply -f deploy/role.yaml -n opendatahub --as system:admin
oc apply -f deploy/role_binding.yaml -n opendatahub --as system:admin
oc apply -f deploy/operator.yaml -n opendatahub --as system:admin
