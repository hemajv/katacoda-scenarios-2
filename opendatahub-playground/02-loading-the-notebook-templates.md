Once the opendatahub operator is deployed, we need to create a `OpenDataHub` Custom Resource that
tells the operator which tools to deploy.


<pre class="file" data-filename="my-odh-cr.yaml" data-target="replace">
apiVersion: opendatahub.io/v1alpha1
kind: OpenDataHub
metadata:
  name:my-odh-cr
spec:
  aicoe-jupyterhub:
    odh_deploy: false
  argo:
    odh_deploy: true
  monitoring:
    enable_pushgateway: false
    odh_deploy: true
  spark-operator:
    odh_deploy: false
</pre>

Once we have enabled all the tools we need to be deployed in the above Custom Resource,
we will create it using the `oc` client.

We can run the following command to do so:
`oc apply -f my-odh-cr.yaml -n opendatahub --as system:admin`{{execute}}
