APB for an HA deployment of wordpress with percona and etcd
Requires ansible >= 2.4, the openshift ansible modules, and kubernetes >= 1.5

Requires the hpa service account have view permissions to replicasets.

If you don't have those permissions set, you can set them with

```bash
{ oc get clusterrole system:hpa-controller -o yaml ; echo '- apiGroups: - extensions - "" attributeRestrictions: null resources: - replicasets/scale verbs: - get - update'; } | oc replace -f -
```
