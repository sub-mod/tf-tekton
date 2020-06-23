oc apply -f pipeline/pipelineresources.yaml
oc apply -f task/build-environment.yaml
oc apply -f task/tensorflow-cpu.yaml
oc apply -f pipeline/pipeline.yaml
oc apply -f pipeline/pipelinerun.yaml
