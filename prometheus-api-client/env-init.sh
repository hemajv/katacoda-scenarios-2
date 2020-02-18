ssh root@host01 'for i in {1..200}; do oc policy add-role-to-user system:image-puller system:anonymous && break || sleep 1; done'
ssh root@host01 'oc adm policy add-cluster-role-to-group sudoer system:authenticated'
ssh root@host01 "mkdir -p /data/pv-01 /data/pv-02 /data/pv-03 /data/pv-04 /data/pv-05 /data/pv-06 /data/pv-07 /data/pv-08 /data/pv-09 /data/pv-10"
ssh root@host01 "chmod 0777 /data/pv-*; chcon -t svirt_sandbox_file_t /data/pv-*;"
ssh root@host01 "oc create -f https://raw.githubusercontent.com/4n4nd/katacoda-scenarios/5007fc039b6a23844eb77a5e20bad6ea6d5d1c67/prometheus-api-client/assets/volumes.json --as system:admin"
# set up dummy metrics in PVC
ssh root@host01 "oc process -f https://raw.githubusercontent.com/4n4nd/katacoda-scenarios/5007fc039b6a23844eb77a5e20bad6ea6d5d1c67/prometheus-api-client/assets/generate-metrics.yaml | oc apply -n myproject -f - --as system:admin"
# wait for metrics to be generated
sleep 10
# set up Prometheus
ssh root@host01 "oc process -f https://raw.githubusercontent.com/4n4nd/katacoda-scenarios/5007fc039b6a23844eb77a5e20bad6ea6d5d1c67/prometheus-api-client/assets/deploy-prometheus.yaml | oc apply -n myproject -f - --as system:admin"
