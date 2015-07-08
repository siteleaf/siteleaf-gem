require File.expand_path('../../spec_helper.rb', __FILE__)

describe 'Page' do
  let(:page) { Siteleaf::Page.new }

  describe '#create_endpoint' do
    subject { page.create_endpoint }
    context 'page API URL Postfix' do
      it 'should end with pages' do
        expect(page.create_endpoint).to end_with('pages')
      end
    end
  end

  describe '#site' do
    subject { page.site }
    context 'Get the Site ID to which that page belongs to' do
      it 'should return site id' do
        expect(page.site).to be_nil
      end
    end
  end

  describe '#assets', vcr: { cassette_name: 'page_assets', record: :none } do
    subject { page.assets }
    context 'Get page assets' do
      it 'should return an array of page assets' do
        expect(page.assets).to be_empty
      end
    end
  end

  describe '#posts', vcr: { cassette_name: 'page_posts', record: :none } do
    subject { page.posts }
    context 'Get page theme using the theme_id' do
      it 'should return a post or nil if no post declared' do
        expect(page.posts[0]).to be_instance_of(Siteleaf::Post)
      end
    end
  end

  describe '#pages', vcr: { cassette_name: 'page_pages', record: :none } do
    subject { page.pages }
    context 'Get page site using the site_id' do
      it 'should return a post or nil if no post declared' do
        expect(page.pages[0]).to be_instance_of(Siteleaf::Page)
      end
    end
  end

  describe '#page' do
    subject { page.page }
    context 'Get page parent id' do
      it 'should id for the parent page' do
        expect(page.page).to be_nil
      end
    end
  end
end
