require File.expand_path('../../spec_helper.rb', __FILE__)

describe 'Page' do
  # let(:post_id) { nil }
  let(:id) { nil }
  let(:parent_id) { nil }
  let(:site_id) { nil }
  let(:attributes) do
    {
      # post_id: post_id,
      id: id,
      parent_id: parent_id,
      site_id: site_id
    }
  end
  let(:page) { Siteleaf::Page.new(attributes) }

  describe '#create_endpoint' do
    subject { page.create_endpoint }
    context 'when site_id is present' do
      let(:site_id) { 'site_id' }
      it { should eql 'sites/site_id/pages' }
    end
    context 'when site_id is nil' do
      it { should eql 'sites//pages' }
    end
  end

  describe '#site' do
    subject { page.site }
    context 'when site_id is present' do
      let(:site_id) { 'site_id' }
      it { should be_an_instance_of Siteleaf::Site }
    end
    context 'when site_id is nil' do
      it { should eql nil }
    end
  end

  describe '#assets', vcr: { cassette_name: 'page_assets', record: :none } do
    subject { page.assets }
    context 'when id is present and page has assets' do
      let(:id) { ENV['PAGE_ID'] }
      it 'should return an array of assets' do
        page.assets.each do |asset|
          expect(asset).to be_instance_of(Siteleaf::Asset)
        end
      end
    end
  end

  describe '#posts', vcr: { cassette_name: 'page_posts', record: :none } do
    subject { page.posts }
    context 'when id is present and page has posts' do
      let(:id) { ENV['PAGE_ID'] }
      it 'should return an array of posts' do
        page.posts.each do |post|
          expect(post).to be_instance_of(Siteleaf::Post)
        end
      end
    end
  end

  describe '#pages', vcr: { cassette_name: 'page_pages', record: :none } do
    subject { page.pages }
    context 'when id is present and page has subpages' do
      let(:id) { ENV['PAGE_ID'] }
      it 'should return an array of pages' do
        page.pages.each do |page|
          expect(page).to be_instance_of(Siteleaf::Page)
        end
      end
    end
  end

  describe '#page' do
    subject { page.page }
    context 'when parent_id is present' do
      let(:parent_id) { 'parent_id' }
      it { should be_an_instance_of Siteleaf::Page }
    end
    context 'when parent_id is nil' do
      it { should eql nil }
    end
  end
end
