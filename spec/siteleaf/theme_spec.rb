require File.expand_path('../../spec_helper.rb', __FILE__)

describe 'Theme' do
  let(:site_id) { nil }
  let(:attributes) do
    {
      site_id: site_id
    }
  end
  let(:theme) { Siteleaf::Theme }

  describe '#self.find_by_site_id' do
    subject { theme.find_by_site_id('site_id') }
    context 'when site_id parameter is passed' do
      it { should be_an_instance_of Siteleaf::Theme }
    end
  end

  describe '#assets', vcr: { cassette_name: 'theme_assets', record: :none } do
    subject { theme.new(attributes).assets }
    context 'when site_id is present and theme has assets' do
      let(:site_id) { ENV['SITELEAF_ID'] }
      it 'should return an array of assets' do
        theme.new(attributes).assets.each do |asset|
          expect(asset).to be_instance_of(Siteleaf::Asset)
        end
      end
    end
  end

  # describe '#assets_by_site_id'  do
  #   subject { theme.assets_by_site_id('site_id') }
  #   context '' do
  #     it { should be_an_instance_of Siteleaf::Asset }
  #   end
  # end

  describe '#site' do
    subject { theme.new.site }
    context 'will always return site object' do
      it { should be_an_instance_of Siteleaf::Site }
    end
  end
end
