require File.expand_path('../../spec_helper.rb', __FILE__)

describe 'version' do
  let(:version) { Siteleaf::VERSION }

  describe '#version' do
    subject { version }
    context 'Validate Siteleaf Version' do
      it 'should not be nil' do
        expect(version).not_to be_nil
      end
    end
  end
end
