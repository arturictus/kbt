require 'spec_helper'
module Kbt
  describe Environment do
    let(:file) { templates_folder.join('environments') }

    it 'gets env from template' do
      e = described_class.new(Template.new(file, 'envs.prod'))
      expect(e.to_h.first.fetch('name')).to eq 'RAILS_ENV'
      expect(e.to_h.first.fetch('value')).to eq 'production'
    end

    it 'overrides when hash is provided' do
      e = described_class.new(
        Template.new(file, 'envs.prod'),
        'RAILS_ENV' => 'overrided_env'
      )
      expect(e.to_h.first.fetch('name')).to eq 'RAILS_ENV'
      expect(e.to_h.first.fetch('value')).to eq 'overrided_env'
    end
  end
end
