oc login -u developer -p developer
oc new-project myproject
curl https://raw.githubusercontent.com/jupyter-on-openshift/jupyter-notebooks/2.4.0/image-streams/s2i-minimal-notebook.json | oc apply -f - -n myproject
curl https://raw.githubusercontent.com/jupyter-on-openshift/jupyter-notebooks/2.4.0/templates/notebook-builder.json | sed -e 's/"Redirect"/"Allow"/' | oc apply -f - -n myproject
curl https://raw.githubusercontent.com/jupyter-on-openshift/jupyter-notebooks/2.4.0/templates/notebook-deployer.json | sed -e 's/"Redirect"/"Allow"/' | oc apply -f - -n myproject
curl https://raw.githubusercontent.com/jupyter-on-openshift/jupyter-notebooks/2.4.0/templates/notebook-quickstart.json | sed -e 's/"Redirect"/"Allow"/' | oc apply -f - -n myproject
curl https://raw.githubusercontent.com/jupyter-on-openshift/jupyter-notebooks/2.4.0/templates/notebook-workspace.json | sed -e 's/"Redirect"/"Allow"/' | oc apply -f - -n myproject

oc process notebook-builder -p GIT_REPOSITORY_URL=https://github.com/hemajv/prometheus-anomaly-detection-workshop.git -p CONTEXT_DIR=source/anomaly-detection | oc apply -f - -n myproject
oc process notebook-deployer -p NOTEBOOK_IMAGE=custom-notebook:latest -p NOTEBOOK_PASSWORD=secret | oc apply -f - -n myproject
sleep 5
oc logs bc/custom-notebook -f
echo -e "-------------------------------------------"
echo -e "The environment should be ready in a few seconds"
echo -e "The url to access the Jupyter Notebooks is: \n http://$(oc get route custom-notebook -o jsonpath='{.spec.host}' -n myproject)"
