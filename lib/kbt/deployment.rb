module Kbt
  class Deployment
    attr_reader :template, :containers, :replicas, :name, :labels
    def initialize(args = {})
      @template = args.fetch(:template)
      @name = args.fetch(:name)
      @labels = args.fetch(:labels)
      @containers = args.fetch(:containers)
      @replicas = args[:replicas] || 1
    end

    def to_h
      Fusu::Hash.deep_merge(
        template.value,
        overrides
      )
    end

    private

    def overrides
      case version
      when 'apps/v1'
        v1
      else
        raise 'version not recognised'
      end
    end

    def version
      template.value['apiVersion']
    end

    def v1
      {
        "metadata" => {
          "name" => name,
          "labels" => labels
        },
        "spec" => {
          'replicas' => replicas,
          'selector' => {
            'matchLabels' => labels
          },
          'template' => {
            'metadata' => { 'labels' => labels },
            'spec' => { 'containers' => containers.map(&:to_h) }
          }
        }
      }
    end

  end
end
