Kbt.define(:nginx) do

  templates_folder File.expand_path('../kube/templates', __dir__)

  container(:nginx_prod) do
    template 'nginx', 'container'
    name 'nginx-container',
    image 'nginx:1.7.9',
    command 'init',
    env 'nginx', 'env.prod'
  end

  container(:nginx_stag) do
    template 'nginx', 'container'
    name 'nginx-stag',
    image 'nginx:1.7.9',
    command 'init',
    env 'nginx', 'env.stag'
  end

  volume(:prod_secrets, 'nginx', 'volumes.prod_secrets')
  volume(:stag_secrets, 'nginx', 'volumes.stag_secrets')

  deployment(:nginx_prod) do
    template 'nginx', 'deployment'
    name 'nginx-prod'
    containers :nginx_prod
    labels { type: 'proxy', env: 'prod' }
    replicas 2
    volumes :prod_secrets
  end

  deployment(:nginx_stag) do
    template 'nginx', 'deployment'
    name 'nginx-stag'
    containers :nginx_stag
    labels { type: 'proxy', env: 'stag' }
    replicas 2
    volumes :stag_secrets
  end

  service(:nginx_service) do
    template 'nginx_services', 'service'
    name 'nginx-service'
    labels { name: 'nginx' }
    selector { app: 'nginx-deployment' }
  end

  ingress(:nginx) do
    template 'nginx_services', 'ingress'
    name 'nginx-prod'
    hosts 'mydomain.com', 'otherdomain.com'
  end

  ingress(:nginx_stag) do
    template 'nginx_services', 'ingress'
    name 'nginx-stag'
    hosts 'stag.mydomain.com', 'stag.otherdomain.com'
  end
end

Kbt.export(:nginx) # exports all the files to folder
Kbt.compile(:nginx) # outputs str ready for [output] > kubectl create -f
