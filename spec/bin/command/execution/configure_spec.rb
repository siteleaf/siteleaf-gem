require File.expand_path('../../../../spec_helper.rb', __FILE__)

describe 'Config' do
  let(:config) { Commands::Execution::Config }

  describe '#self.config_ru_text' do
    subject { config.config_ru_text }
    context 'Text to be written in config.ru file' do
      it 'should return text with site id in it for config.ru' do
        # Pending
      end
    end
  end

  describe '#self.not_configured' do
    subject { config.not_configured }
    context 'prints site is not configured on the users terminal' do
      it 'should return false' do
        expect(config.not_configured).to be_falsey
      end
    end
  end

  describe '#self.config' do
    subject { config.config }
    context '' do
      it '' do
        # pending
      end
    end
  end
end
