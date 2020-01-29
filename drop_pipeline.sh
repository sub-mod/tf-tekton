oc delete pipelineresource/build-image
oc delete pipelineresource/git-repo
oc delete pipeline/tf-build-pipeline
oc delete task/tf-run
oc delete pipelinerun/tf-build-pipeline-run
