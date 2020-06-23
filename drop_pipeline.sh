oc delete -f pipeline/pipelineresources.yaml
oc delete -f task/build-environment.yaml
oc delete -f task/tensorflow-cpu.yaml
oc delete -f pipeline/pipeline.yaml
oc delete -f pipeline/pipelinerun.yaml
