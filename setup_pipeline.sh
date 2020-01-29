oc process -p GIT_RELEASE_REPO=<github repo> -p GIT_TOKEN=<token> -f pipeline/secret.yaml | oc apply -f -
oc apply -f pipeline/serviceaccount.yaml
oc apply -f pipeline/pipelineresources.yaml
oc apply -f pipeline/task.yaml
oc apply -f task/buildah.yaml
oc apply -f pipeline/pipeline.yaml
oc apply -f pipeline/pipelinerun.yaml
