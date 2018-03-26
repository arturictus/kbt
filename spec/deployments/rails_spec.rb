require 'spec_helper'
module Kbt
  describe 'rails deployment' do
    let(:path) { Kbt.templates_folder }
    let(:template) { path.join('rails') }
    let(:volume) do
      # Volume.new(template: Template.new(path.join('rails_components'), 'volumes.prod_secrets'))
      Template.new(path.join('rails_components'), 'volumes.prod_secrets')
    end
    let(:container) do
      Container.new(
        template: Template.new(path.join('rails_components'), 'containers.web'),
        name: 'rails-container',
        image: 'rails:1.7.9',
        command: 'init',
        env: Environment.new(Template.new(path.join('rails_components'), 'envs.prod'))
      )
    end
    let(:deployment) do
      Deployment.new(
        template: Template.new(template),
        name: 'rails-deployment',
        containers: [container],
        labels: {type: 'proxy'},
        replicas: 2,
        overrides: { 'terminationGracePeriodSeconds' => 40 },
        volumes: [volume]
      )
    end

    it "container" do
      h = container.to_h
      expect(h.fetch('name')).to eq 'rails-container'
      expect(h.fetch('image')).to eq 'rails:1.7.9'
      expect(h.fetch('command')).to eq 'init'
      expect(h.fetch('env').first.fetch('name')).to eq 'RAILS_ENV'
    end

    it 'deployment' do
      h = deployment.to_h
      expect(h.fetch('metadata').fetch('name')).to eq 'rails-deployment'
      spec = h.fetch('spec')
      template_spec = spec.fetch('template').fetch('spec')
      expect(spec.fetch('replicas')).to eq 2
      expect(template_spec.fetch('containers').first).to eq container.to_h
      expect(template_spec.fetch('terminationGracePeriodSeconds')).to eq 40
    end
  end
end
