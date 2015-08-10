require File.expand_path('../../spec_helper.rb', __FILE__)

describe 'Asset' do
  let(:post_id) { nil }
  let(:theme_id) { nil }
  let(:page_id) { nil }
  let(:site_id) { nil }
  let(:attributes) { { post_id: post_id, theme_id: theme_id, page_id: page_id, site_id: site_id } }
  let(:asset) { Siteleaf::Asset.new(attributes) }

  describe '#create_endpoint' do
    subject { asset.create_endpoint }
    context 'when site_id is present' do
      let(:site_id) { SITE_ID }
      it { should eql "sites/#{SITE_ID}/assets" }
    end
    context 'when theme_id and site_id is present' do
      let(:theme_id) { SITE_ID }
      let(:site_id) { SITE_ID }
      it { should eql "sites/#{SITE_ID}/theme/assets" }
    end
    context 'when post_id is present' do
      let(:post_id) { POST_ID }
      it { should eql "posts/#{POST_ID}/assets" }
    end
    context 'when page_id is present' do
      let(:page_id) { PAGE_ID }
      it { should eql "pages/#{PAGE_ID}/assets" }
    end
    context 'when page_id, post_id, and theme_id are all nil' do
      it { should eql 'sites//assets' }
    end
  end

  describe '#post' do
    subject { asset.post }
    context 'when post_id is present' do
      let(:post_id) { POST_ID }
      it { should be_an_instance_of Siteleaf::Post }
    end
    context 'when post_id is nil' do
      it { should eql nil }
    end
  end

  describe '#page' do
    subject { asset.page }
    context 'when page_id is present' do
      let(:page_id) { PAGE_ID }
      it { should be_an_instance_of Siteleaf::Page }
    end
    context 'when page_id is nil' do
      it { should eql nil }
    end
  end

  describe '#theme' do
    subject { asset.theme }
    context 'when theme_id is present' do
      let(:theme_id) { SITE_ID }
      it { should be_an_instance_of Siteleaf::Theme }
    end
    context 'when theme_id is nil' do
      it { should eql nil }
    end
  end

  describe '#site' do
    subject { asset.site }
    context 'when site_id is present' do
      let(:site_id) { SITE_ID }
      it { should be_an_instance_of Siteleaf::Site }
    end
    context 'when site_id is nil' do
      it { should eql nil }
    end
  end
end
