module Kbt
  class Deployment
    attr_reader :template,
                :containers,
                :replicas,
                :name,
                :labels,
                :template_overrides

    def initialize(args = {})
      @template = args.fetch(:template)
      @name = args.fetch(:name)
      @labels = args.fetch(:labels)
      @containers = args.fetch(:containers)
      @replicas = args[:replicas] || 1
      @template_overrides = args[:overrides] || {}
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
      when 'apps/v1', 'apps/v1beta2'
        v1
      when 'extensions/v1beta1', 'apps/v1beta1'
        v1beta1
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
          'template' => _template
        }
      }
    end

    def _template
      {
        'metadata' => { 'labels' => labels },
        'spec' => spec
      }
    end

    def spec
      {
        'containers' => containers.map(&:to_h)
      }.merge(template_overrides)
      # TODO add volumes
    end

    def v1beta1
      {
        "metadata" => {
          "name" => name,
          "labels" => labels
        },
        "spec" => {
          'replicas' => replicas,
          'template' => _template
        }
      }
    end
  end
end
