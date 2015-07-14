require File.expand_path('../../spec_helper.rb', __FILE__)

describe 'Asset' do
  let(:asset_site_id) { Siteleaf::Asset.new(site_id: ENV['SITELEAF_ID']) }
  let(:asset_theme_id) { Siteleaf::Asset.new(site_id: ENV['SITELEAF_ID'], theme_id: ENV['SITELEAF_ID']) }
  let(:asset_page_id) { Siteleaf::Asset.new(page_id: ENV['PAGE_ID']) }
  let(:asset_post_id) { Siteleaf::Asset.new(post_id: ENV['POST_ID']) }
  let(:asset) { Siteleaf::Asset.new }

  describe '#create_endpoint' do
    context 'should return HTTP URL Endpoint "sites/{site_id}/assets" if site_id is provided' do
      subject { asset_site_id.create_endpoint }
      it { should eql "sites/#{ENV['SITELEAF_ID']}/assets" }
    end
    context 'should return HTTP URL Endpoint "sites/{theme_id}/theme/assets" if theme_id is provided' do
      subject { asset_theme_id.create_endpoint }
      it { should eql "sites/#{ENV['SITELEAF_ID']}/theme/assets" }
    end
    context 'should return HTTP URL Endpoint "pages/{page_id}/assets" if page_id is provided' do
      subject { asset_page_id.create_endpoint }
      it { should eql "pages/#{ENV['PAGE_ID']}/assets" }
    end
    context 'should return HTTP URL Endpoint "posts/{post_id}/assets" if post_id is provided' do
      subject { asset_post_id.create_endpoint }
      it { should eql "posts/#{ENV['POST_ID']}/assets" }
    end
  end

  describe '#post' do
    context 'Should return post if post_id is provided' do
      subject { asset_post_id.post }
      it { should be_an_instance_of Siteleaf::Post }
    end
    context 'Should return nil if post_id is not provided' do
      subject { asset.post }
      it { should eql nil }
    end
  end

  describe '#page' do
    context 'Should return page if page_id is provided' do
      subject { asset_page_id.page }
      it { should be_an_instance_of Siteleaf::Page }
    end
    context 'Should return nil if page_id is not provided' do
      subject { asset.page }
      it { should eql nil }
    end
  end

  describe '#theme' do
    context 'Should return theme if theme_id is provided' do
      subject { asset_theme_id.theme }
      it { should be_an_instance_of Siteleaf::Theme }
    end
    context 'Should return nil if theme_id is not provided' do
      subject { asset.theme }
      it { should eql nil }
    end
  end

  describe '#site'do
    context 'Should return site if site_id is provided' do
      subject { asset_site_id.site }
      it { should be_an_instance_of Siteleaf::Site }
    end
    context 'Should return nil if site_id is not provided' do
      subject { asset.site }
      it { should eql nil }
    end
  end
end
