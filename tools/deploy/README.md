# Deploy Lucida using Kubernetes

0. Prerequisites.
  Docker is installed, port 8080 is not in use,
  and you have at least 18 GB of disk space and 16 GB of memory.
  The Docker image contains all the compiled dependencies, ASR models, Stanford CoreNLP packages, etc.,
  and make sure your docker allows you to pull an image of 18 GB.
  The disk usgae will increase as users add data to Lucida.
  If you need to set memory and CPU limits for Kubernetes,
  please refer to [this](http://kubernetes.io/docs/admin/limitrange/).

1. Run `sudo ./cluster_up.sh` to create a Kubernetes cluster on a single machine via Docker.
  If you want to create a cluster with more than one machines,
  please refer to [the official documentation](http://kubernetes.io/docs/).

2. Open `mongo-controller.yaml` and `qa-controller.yaml` and modify the `hostPath` fields
  to point to the directories where you want to store the data for MongoDB and OpenEphyra.
  Make sure you have write access to the directories you specify. 

  Move the Wikipedia knowledge base to the correct directory according to the inline comment in
  `qa-controller.yaml` if you choose to use it as an addition to the user-input knowledge base.
  Otherwise, remove `export wiki_indri_index=...` from the `args` field.

  Modify the number of replicas in `*-controller`s if the default parameter does not suffice.

3. If you prefer to build the Docker image from [the top level Dockerfile](../../Dockerfile)
  rather than pulling from our Dockerhub, you need to modify
  the `image` fields of all `*-controller`s and set up a local Kubernetes container registry.

4. If you have SSL certificates and want to set up https, please modify the following files according to their inline comments:

  ```
  web-controller-https.yaml
  asrmaster-controller-https.yaml
  ```
  
  , and then rename the following files:
  
  ```
  mv asrworker-controller-https.yaml asrworker-controller.yaml
  mv asrmaster-controller-https.yaml asrmaster-controller.yaml
  mv web-controller-https.yaml web-controller.yaml
  mv web-service-https.yaml web-service.yaml
  ```

5. Run `sudo ./start_services.sh` to launch all Kubernetes services and pods.
  It assumes that a local cluster is set up.
  To debug, you can run `kubectl get service` to check the services,
  `kubectl get pod` and `kubectl describe pod` to check the pods,
  `docker ps | grep <controller_name>` followed by `docker exec -it <running_container_id> bash` to check the running containers.
  For example, if you see "Internal Server Error", you should check the web container,
  and see the error logs in `/usr/local/lucida/lucida/commandcenter/apache/logs/`.
  Also, if MongoDB container is constantly being created without making progress, 
  run `sudo netstat -tulpn | grep 27017` and kill the currently running MongoDB instance which also uses the port 27017.
  This also applies to other containers, e.g. Memcached, qa, etc. whose ports are already used and thus cannot be started.

6. Open your browser and visit `http://localhost:30000` (or `https://<YOUR_DOMAIN_NAME>:30000` if you set up https in step 4).
  It may take up to several minutes for the Apache server to start working,
  but if it seems to take forever for the index page to show up, please debug as described in step 5.

7. To destroy the cluster, run `docker ps`, then `stop` and `rm` all the containers related to Kubernetes.
   The following function may be helpful if you want to stop and remove all Docker containers.

  ```
  function docker-flush(){
    dockerlist=$(docker ps -a -q)
      if [ "${dockerlist}" != "" ]; then
        for d in ${dockerlist}; do
          echo "***** ${d}"
          docker stop ${d} 2>&1 > /dev/null
          docker rm ${d} 2>&1 > /dev/null
          done
        fi
  }
  ```
