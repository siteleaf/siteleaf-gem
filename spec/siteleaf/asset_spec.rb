require File.expand_path('../../spec_helper.rb', __FILE__)

describe 'Asset' do
  let(:asset) { Siteleaf::Asset.new }

  describe '#create_endpoint' do
    subject { asset.create_endpoint }
    context 'Asset API URL Postfix' do
      it 'should end with assets' do
        expect(asset.create_endpoint).to end_with('assets')
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
