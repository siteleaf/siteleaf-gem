require_relative 'spec_helper'

describe 'Siteleaf' do
  let(:siteleaf) { Siteleaf }

  describe '#api_url' do
    subject { siteleaf.api_url }
    context 'API URL Prefix' do
      it { should eql 'https://api.siteleaf.com/v1/' }
    end
  end

  describe '#self.settings_file' do
    subject { siteleaf.settings_file }
    context 'Returns a settings File' do
      it 'may or may not return' do
        # As Figs was put in this file may or may not exist
      end
    end
  end

  describe '#self.load_env_vars' do
    subject { siteleaf.load_env_vars }
    context 'Returns a settings File' do
      it { should be_falsy }
    end
  end

  describe '#self.load_settings' do
    subject { siteleaf.load_settings }
    context 'Returns a settings File' do
      # pending
    end
  end
end
