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
        command: 'init',
        env: Environment.new(Template.new(template, 'env.prod'))
      )
    end
    let(:deployment) do
      Deployment.new(
        template: Template.new(template, 'deployment'),
        name: 'nginx-deployment',
        containers: [container],
        labels: {type: 'proxy'},
        replicas: 2
      )
    end

    it "container" do
      h = container.to_h
      expect(h.fetch('name')).to eq 'nginx-container'
      expect(h.fetch('image')).to eq 'nginx:1.7.9'
      expect(h.fetch('command')).to eq 'init'
      expect(h.fetch('env').first.fetch('name')).to eq 'HELLO'
    end

    it 'deployment' do
      h = deployment.to_h
      expect(h.fetch('metadata').fetch('name')).to eq 'nginx-deployment'
      spec = h.fetch('spec')
      expect(spec.fetch('replicas')).to eq 2
      expect(spec.fetch('template').fetch('spec').fetch('containers').first).to eq container.to_h
    end
  end
end
