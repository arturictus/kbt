require 'spec_helper'
module Kbt
  describe Template do
    let(:valid) do
      described_class.new(templates_folder.join('template'), 'volumes.prod_secrets')
    end
    let(:no_file) do
      described_class.new(templates_folder.join('no_file'), 'volumes.prod_secrets')
    end
    let(:no_key) do
      described_class.new(templates_folder.join('template'), 'volumes.NO_KEY')
    end
    let(:wrong_format) do
      described_class.new(templates_folder.join('wrong_format'), 'volumes.NO_KEY')
    end

    describe '#to_h' do
      it 'when everthing is ok returns value' do
        expect(valid.to_h.fetch('name')).to eq "prod-secrets-template"
      end
      it 'when no file raises error `WrongFile' do
        expect { no_file.to_h }.to raise_error(Template::WrongFile)
      end
      it 'when no key raises error `WrongKey' do
        expect { no_key.to_h }.to raise_error(Template::WrongKey)
      end
      it 'when no key raises error `NotValidYaml' do
        expect { wrong_format.to_h }.to raise_error(Template::NotValidYaml)
      end
    end

    describe '#validate!' do
      it 'when everthing is ok returns value' do
        expect{ valid.validate! }.not_to raise_error
      end
      it 'when no file raises error `WrongFile' do
        expect { no_file.validate! }.to raise_error(Template::WrongFile)
      end
      it 'when no key raises error `WrongKey' do
        expect { no_key.validate! }.to raise_error(Template::WrongKey)
      end
      it 'when no key raises error `NotValidYaml' do
        expect { wrong_format.validate! }.to raise_error(Template::NotValidYaml)
      end
    end

    describe '#valid?' do
      it 'does not raises errors, returns true or false' do
        expect(valid.valid?).to be true
        expect(no_file.valid?).to be false
        expect(no_key.valid?).to be false
        expect(wrong_format.valid?).to be false
      end
    end
  end
end
