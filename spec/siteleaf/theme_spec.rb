require File.expand_path('../../spec_helper.rb', __FILE__)

describe 'Theme' do
  let(:site_id) { nil }
  let(:attributes) { { site_id: site_id } }
  let(:theme) { Siteleaf::Theme }

  describe '#self.find_by_site_id' do
    subject { theme.find_by_site_id('SITE_ID') }
    context 'when site_id parameter is passed' do
      it { should be_an_instance_of Siteleaf::Theme }
    end
  end

  describe '#assets' do
    before do
      stub_request(:get, %r{sites\/#{ENV['SITE_ID']}\/theme\/assets\z}).to_return(body: ENV['assets'], headers: { content_type: 'application/json' })
      stub_request(:get, %r{sites\/\/theme\/assets\z}).to_return(body: ENV['error'], headers: { content_type: 'application/json' })
    end
    subject { theme.new(attributes).assets }
    context 'when site_id is present' do
      let(:site_id) { ENV['SITE_ID'] }
      it { should be_instance_of Array }
      it 'should return an array of assets' do
        theme.new(attributes).assets.each { |asset| expect(asset).to be_instance_of(Siteleaf::Asset) }
      end
    end
    context 'when site_id is nil' do
      it 'should raise error for each_pair function in attributes function' do
        expect { theme.new(attributes).assets }.to raise_error NoMethodError
      end
    end
  end

  describe '#assets_by_site_id' do
    before do
      stub_request(:get, %r{sites\/#{ENV['SITE_ID']}\/theme\/assets\z}).to_return(body: ENV['assets'], headers: { content_type: 'application/json' })
      stub_request(:get, %r{sites\/\/theme\/assets\z}).to_return(body: ENV['error'], headers: { content_type: 'application/json' })
    end
    subject { theme.assets_by_site_id(ENV['SITE_ID']) }
    context 'when site_id is passed as parameter' do
      it { should be_an_instance_of Array }
      it 'should return an array of assets' do
        theme.assets_by_site_id(ENV['SITE_ID']).each { |asset| expect(asset).to be_instance_of(Siteleaf::Asset) }
      end
    end
    context 'when site_id is nil' do
      it 'should raise error for each_pair function in attributes function' do
        expect { theme.new(attributes).assets }.to raise_error NoMethodError
      end
    end
  end

  describe '#site' do
    subject { theme.new(attributes).site }
    context 'when site_id is present' do
      let(:site_id) { ENV['SITE_ID'] }
      it { should be_an_instance_of Siteleaf::Site }
    end
  end
end
