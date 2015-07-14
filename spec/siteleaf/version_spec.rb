require File.expand_path('../../spec_helper.rb', __FILE__)

describe 'version' do
  let(:version) { Siteleaf::VERSION }

  describe '#version' do
    subject { version }
    context 'Gives version of Siteleaf-Gem' do
      it { should_not eql nil }
    end
  end
end
