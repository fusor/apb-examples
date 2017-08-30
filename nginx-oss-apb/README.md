# Ansible Playbook Bundle for NGINX OSS

An Ansible Playbook Bundle (APB) for deploying a single instance of NGINX OSS.

## How to Test the NGINX OSS Service

1. Select the NGINX service, add it to `My Project`, select `Create` and click `View Project`.
2. After waiting for a few seconds you should see a URL pop in the top-right corner of the project overview GUI. That URL will take you to the default NGINX landing page.

## Sample Tutorial Walkthrough

1. Deploy Python and PHP web servers by clicking each of the respective icons in the service catalog. For each service, select the `try sample repository` option, click `create` and finally `view project`. Wait for a few minutes until the deployment has completed.
2. Once the deployment has finished, for each service select the drop-down arrow and click the link under the service header. You will be able to see the internal IP of the pod from here. Store the internal IP of both pods (note: while not explicitly specified all default pods are open at port 8080 instead of the normal default port 80 due to security reasons).
3. Select the NGINX service. You will be able to edit a few NGINX configuration options. Select `Enable Load Balancing` and input the internal IPs of the Python and PHP services as a comma separated list in the `Load Balanced Servers` textfield. Once you are done add the service to `My Project`, select `Create` and click `View Project`.
4. After waiting for a few seconds you should see a URL pop in the top-right corner of the project overview GUI. Voila! You have a functional NGINX Load Balancer!

## Parameters

Name | Default Value | Required | Description
---|---|---|---
lb | false | No | Enable Load Balancing
server | - | No | Load Balanced Servers (Input as a Comma Separated List and Add Port 8080)
lb_method | round_robin | No | Load Balancing Algorithm


## License

[Simplified BSD License](https://github.com/nginxinc/nginx-oss-apb/blob/master/LICENSE)

## Author

Alessandro Fael Garcia

[NGINX Inc](https://www.nginx.com/)
