# Tensorflow Tekton Pipelines

k8s-style CI/CD pipeline for Tensorflow builds

## Local Testing

### Pipeline Test

1. Setup Tekton Pipeline in cluster. Follow [Tekton Pipeline Documentation](https://github.com/tektoncd/pipeline/blob/master/docs/install.md)
2. Create the resources for the example:

  ```bash
  oc process -p GIT_RELEASE_REPO=<github repo> -p GIT_TOKEN=<token> -f pipeline/secret.yaml | oc apply -f -
  oc apply -f pipeline/serviceaccount.yaml
  oc apply -f pipeline/pipelineresources.yaml
  oc apply -f pipeline/task.yaml
  oc apply -f task/buildah.yaml
  oc apply -f pipeline/pipeline.yaml
  oc apply -f pipeline/pipelinerun.yaml
  ```

### Trigger Test

1. Setup Tekton Pipeline and Tekton Trigger in cluster. Follow [Tekton Pipeline Documentation](https://github.com/tektoncd/pipeline/blob/master/docs/install.md) and [Tekton Trigger Documentation](https://github.com/tektoncd/triggers/blob/master/docs/install.md)
2. Create the resources for the example:

  ```bash
  oc process -p GIT_RELEASE_REPO=<github repo> -p GIT_TOKEN=<token> -f pipeline/secret.yaml | oc apply -f -
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
