require File.expand_path('../../spec_helper.rb', __FILE__)

describe 'Asset' do
  let(:asset_site_id) { Siteleaf::Asset.new({ site_id: '1' }) }
  let(:asset_theme_id) { Siteleaf::Asset.new({ theme_id: '1' }) }
  let(:asset_post_id) { Siteleaf::Asset.new({ post_id: '1' }) }
  let(:asset_page_id) { Siteleaf::Asset.new({ site_id: '1' }) }

  describe '#create_endpoint' do
    subject { asset_site_id.create_endpoint }
    context 'Must return the HTTP URL Endpoint to retrieve site' do
      it 'should return sites/{site_id}/assets' do
        expect(asset_site_id.create_endpoint).to eql('sites/1/assets')
      end
    end
  end

  describe '#post' do
    subject { asset.post }
    context 'Get Asset Post using the post_id' do
      it 'should return a post or nil if no post declared' do
        expect(asset.post).to be_nil
      end
    end
  end

  describe '#page' do
    subject { asset.page }
    context 'Get Asset page using the page_id' do
      it 'should return a post or nil if no post declared' do
        expect(asset.page).to be_nil
      end
    end
  end

  describe '#theme' do
    subject { asset.theme }
    context 'Get Asset theme using the theme_id' do
      it 'should return a post or nil if no post declared' do
        expect(asset.theme).to be_nil
      end
    end
  end

  describe '#site' do
    subject { asset.site }
    context 'Get Asset site using the site_id' do
      it 'should return a post or nil if no post declared' do
        expect(asset.site).to be_nil
      end
    end
  end
end
