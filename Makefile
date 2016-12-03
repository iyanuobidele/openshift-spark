LOCAL_IMAGE=kube-spark:snapshot
SPARK_IMAGE=quay.io/intelccc/kube-spark:snapshot

SPARK_DISTRO=/home/iyanu/Downloads/spark-2.1.0-SNAPSHOT-bin-custom-k8s-spark.tar.gz

# If you're pushing to an integrated registry
# in Openshift, SPARK_IMAGE will look something like this

# SPARK_IMAGE=172.30.242.71:5000/myproject/openshift-spark

.PHONY: build clean push create destroy

build:
	cp $(SPARK_DISTRO) spark-distro.tgz
	docker build --build-arg=http_proxy --build-arg=https_proxy -t $(LOCAL_IMAGE) .

clean:
	docker rmi $(LOCAL_IMAGE)

push: #build
	docker tag $(LOCAL_IMAGE) $(SPARK_IMAGE)
	docker push $(SPARK_IMAGE)

create: push template.yaml
	oc process -f template.yaml -v SPARK_IMAGE=$(SPARK_IMAGE) > template.active
	oc create -f template.active

destroy: template.active
	oc delete -f template.active
	rm template.active
