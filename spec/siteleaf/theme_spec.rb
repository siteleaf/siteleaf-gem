require File.expand_path('../../spec_helper.rb', __FILE__)

describe 'Theme' do
  let(:theme) { Siteleaf::Theme }
  let(:theme_obj) { Siteleaf::Theme.new }

  describe '#self.find_by_site_id' do
    subject { theme.find_by_site_id }
    context ' Theme for the site' do
      it 'should return the entire theme for the site using site_id' do
        expect(theme.find_by_site_id('Pass Something')).to be_instance_of(Siteleaf::Theme)
      end
    end
  end

  describe '#assets', vcr: { cassette_name: 'theme_assets', record: :none } do
    subject { theme_obj.assets }
    context 'Get all the theme assets' do
      it 'should return an array of assets or nil if no asset declared' do
        expect(theme_obj.assets[0]).to be_instance_of(Siteleaf::Asset)
      end
    end
  end

  describe '#site' do
    subject { theme_obj.site }
    context 'Get the Site to which theme belongs to' do
      it 'should return the parent Site object' do
        expect(theme_obj.site).to be_instance_of(Siteleaf::Site)
      end
    end
  end
end
