Once the opendatahub operator is deployed, we need to create a `OpenDataHub` Custom Resource that
tells the operator which tools to deploy.


<pre class="file" data-filename="my-odh-cr.yaml" data-target="replace">
apiVersion: opendatahub.io/v1alpha1
kind: OpenDataHub
metadata:
  name: my-odh-cr
spec:
  aicoe-jupyterhub:
    # Deploy the ODH aicoe-jupyterhub role if True
    odh_deploy: true
    notebook_cpu: 1
    notebook_memory: 2Gi
    spark:
      # Spark image to use in the cluster
      worker:
        # Number of spark worker nodes
        instances: 1
        # Amount of cpu & memory resources to allocate to the each worker node in the cluster.
        resources:
          limits:
            memory: 1Gi
            cpu: 1
          requests:
            memory: 1Gi
            cpu: 500m
      master:
        # Number of spark master nodes
        instances: 1
        # Amount of cpu & memory resources to allocate to the each node in the cluster.
        resources:
          limits:
            memory: 1Gi
            cpu: 1
          requests:
            memory: 512Mi
            cpu: 500m
  spark-operator:
    odh_deploy: false
  monitoring:
    enable_pushgateway: false
    odh_deploy: true
</pre>

Once we have enabled all the tools we need to be deployed in the above Custom Resource,
we will create it using the `oc` client.

We can run the following command to do so:
`oc apply -f my-odh-cr.yaml -n opendatahub --as system:admin`{{execute}}
