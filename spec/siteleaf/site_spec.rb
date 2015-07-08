require File.expand_path('../../spec_helper.rb', __FILE__)

describe 'Site' do
  let(:site) { Siteleaf::Site.new }

  describe '#theme' do
    subject { site.theme }
    context ' Theme for the site' do
      it 'should return the entire theme for the site' do
        expect(site.theme).to be_instance_of(Siteleaf::Theme)
      end
    end
  end

  describe '#assets', vcr: { cassette_name: 'site_assets', record: :none } do
    subject { site.assets }
    context 'Get site assets' do
      it 'should return an array of site assets' do
        expect(site.assets).to be_empty
      end
    end
  end

  describe '#pages', vcr: { cassette_name: 'site_pages', record: :none } do
    subject { site.pages }
    context 'Get all pages in site using the site_id' do
      it 'should return a page or nil if no page declared' do
        expect(site.pages[0]).to be_instance_of(Siteleaf::Page)
      end
    end
  end

  describe '#posts', vcr: { cassette_name: 'site_posts', record: :none } do
    subject { site.posts }
    context 'Get all the site posts using the site_id' do
      it 'should return an array of posts or nil if no post declared' do
        expect(site.posts[0]).to be_instance_of(Siteleaf::Post)
      end
    end
  end
end
