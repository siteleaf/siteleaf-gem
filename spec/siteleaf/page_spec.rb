require File.expand_path('../../spec_helper.rb', __FILE__)

describe 'Page' do
  let(:id) { nil }
  let(:parent_id) { nil }
  let(:site_id) { nil }
  let(:attributes) do
    {
      id: id,
      parent_id: parent_id,
      site_id: site_id
    }
  end
  let(:page) { Siteleaf::Page.new(attributes) }

  describe '#create_endpoint' do
    subject { page.create_endpoint }
    context 'when site_id is present' do
      let(:site_id) { ENV['SITELEAF_ID'] }
      it { should eql 'sites/SITE_ID/pages' }
    end
    context 'when site_id is nil' do
      it { should eql 'sites//pages' }
    end
  end

  describe '#site' do
    subject { page.site }
    context 'when site_id is present' do
      let(:site_id) { ENV['SITELEAF_ID'] }
      it { should be_an_instance_of Siteleaf::Site }
    end
    context 'when site_id is nil' do
      it { should eql nil }
    end
  end

  describe '#assets', vcr: { cassette_name: 'page_assets', record: :none } do
    subject { page.assets }
    context 'when id is present' do
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
    context 'when id is present' do
      let(:id) { ENV['PAGE_ID'] }
      it 'should return an array of posts' do
        page.posts.each do |post|
          expect(post).to be_instance_of(Siteleaf::Post)
        end
      end
    end
  end

  describe '#pages', vcr: { cassette_name: 'page_pages', record: :none } do
    subject { page.pages[0] }
    context 'when id is present' do
      let(:id) { ENV['PAGE_ID'] }
      it { should be_an_instance_of Siteleaf::Page }
    end
  end

  describe '#page' do
    subject { page.page }
    context 'when parent_id is present' do
      let(:parent_id) { ENV['PARENT_ID'] }
      it { should be_an_instance_of Siteleaf::Page }
    end
    context 'when parent_id is nil' do
      it { should eql nil }
    end
  end
end
