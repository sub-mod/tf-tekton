# Tensorflow Build Pipeline

Tensorflow build pipeline is developed with tekton and openshift pipelines.<br>
These build pipeline executes source build process of tensorflow with different CPU and GPU build parameters.

## Setup Environment

The Build environment is currently setup on OpenShift 3.11 cluster.<br>
`[tekton-trigger](https://github.com/tektoncd/pipeline/tree/v0.10.2)`: `v0.10.2` is being used for pipelines.

Following commands can be executed to setup similar pipeline of openshift 3.11 cluster:

```bash
oc new-project tekton-pipelines
oc adm policy add-scc-to-user anyuid -z tekton-pipelines-controller
oc apply --filename https://storage.googleapis.com/tekton-releases/pipeline/previous/v0.10.2/release.yaml
```

Additional details for tekton pipeline setup can be found [here](https://github.com/tektoncd/pipeline/blob/v0.10.2/docs/install.md#installing-tekton-pipelines-on-openshiftminishift)

Build environment is also setup with tekton trigger.<br>
`[tekton-trigger](https://github.com/tektoncd/triggers/tree/v0.3.1)`: `v0.3.1`

```bash
oc apply --filename https://storage.googleapis.com/tekton-releases/triggers/previous/v0.3.0/release.yaml
```

Additional details for tekton trigger setup can be found [here](https://github.com/tektoncd/triggers/blob/v0.3.1/docs/install.md)

## Local Testing

1. Setup Tekton Pipeline and Tekton Trigger in cluster. Follow [Tekton Pipeline Documentation](https://github.com/tektoncd/pipeline/blob/master/docs/install.md) and [Tekton Trigger Documentation](https://github.com/tektoncd/triggers/blob/master/docs/install.md)

2. Create the resources for the example:

  ```bash
  oc apply -f trigger/serviceaccount.yaml
  oc apply -f trigger/role.yaml
  oc apply -f trigger/binding.yaml
  oc apply -f trigger/triggertemplate.yaml
  oc apply -f trigger/triggerbinding.yaml
  oc apply -f trigger/eventlistener.yaml
  oc apply -f trigger/task.yaml
  oc apply -f task/buildah.yaml
  oc apply -f trigger/pipeline.yaml
  ```

3. Send a payload to the listener at port 8080<br>
  port-forwarded with `oc port-forward $(oc get pod -o=name -l eventlistener=listener) 8080`

```bash
curl -X POST \
  http://localhost:8080 \
  -H 'Content-Type: application/json' \
  -H 'X-Hub-Signature: sha1=2da37dcb9404ff17b714ee7a505c384758ddeb7b' \
  -d '{
    "head_commit":
    {
        "id": "r1.14"
    },
    "repository":
    {
        "url": "https://github.com/tensorflow/tensorflow.git",
        "branch": "r1.14"
    }
}'
```
