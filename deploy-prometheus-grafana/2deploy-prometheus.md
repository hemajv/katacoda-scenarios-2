

First let's create a new namespace to deploy our monitoring tools.

`oc new-project pad-monitoring`{{execute}}

Now we need to edit the configmap in our prometheus deployment template, to scrape our demo application.
To do that, we need to add the following section:

Open the deployment template in the editor:
`/root/deploy-prometheus.yaml`{{open}}

`deploy-prometheus.yaml`{{open}}

`assets/deploy-prometheus.yaml`{{open}}

<pre class="file">
- targets: ['http://metrics-demo-app-metrics-demo.[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com']
  labels:
    group: 'demo-app'
</pre>

Once we have added it to the configMap, we can go ahead and deploy it using the following command.

`oc process -f deploy-prometheus.yaml | oc apply -n pad-monitoring -f -`{{execute}}

To see the url for your Prometheus instance, run the following command:
`echo -e "http://$(oc get route prometheus-demo-route -o jsonpath='{.spec.host}' -n pad-monitoring)"`{{execute}}

or you can use the console to check on the Prometheus deployment.
