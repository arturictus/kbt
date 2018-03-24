require 'spec_helper'
module Kbt
  describe 'nginx deployment' do
    let(:path) { Kbt.templates_folder }
    let(:template) { path.join('nginx') }
    let(:container) do
      Container.new(
        template: Template.new(template, 'container'),
        name: 'nginx-container',
        image: 'nginx:1.7.9',
        env: Environment.new(Template.new(template, 'env.prod'))
      )
    end
    let(:deployment) do
      Deployment.new(
        template: Template.new(template, 'deployment'),
        name: 'nginx-deployment',
        containers: [container],
        labels: {type: 'proxy'}
      )
    end
  end
end
