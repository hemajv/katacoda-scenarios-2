oc logs bc/custom-notebook
echo -e "The url to access the Jupyter Notebooks is: \n http://$(oc get route custom-notebook -o jsonpath='{.spec.host}' -n myproject)"
