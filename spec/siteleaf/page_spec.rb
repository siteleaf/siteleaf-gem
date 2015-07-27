require File.expand_path('../../spec_helper.rb', __FILE__)

describe 'Page' do
  let(:id) { nil }
  let(:parent_id) { nil }
  let(:site_id) { nil }
  let(:attributes) { {  id: id, parent_id: parent_id, site_id: site_id } }
  let(:page) { Siteleaf::Page.new(attributes) }

  describe '#create_endpoint' do
    subject { page.create_endpoint }
    context 'when site_id is present' do
      let(:site_id) { SITE_ID }
      it { should eql "sites/#{SITE_ID}/pages" }
    end
    context 'when site_id is nil' do
      it { should eql 'sites//pages' }
    end
  end

  describe '#site' do
    subject { page.site }
    context 'when site_id is present' do
      let(:site_id) { SITE_ID }
      it { should be_an_instance_of Siteleaf::Site }
    end
    context 'when site_id is nil' do
      it { should eql nil }
    end
  end

  describe '#assets' do
    subject { page.assets }
    context 'when id is present' do
      let(:id) { PAGE_ID }
      before { stub_request(:get, %r{pages\/#{PAGE_ID}\/assets\z}).to_return(body: ASSETS, headers: { content_type: 'application/json' }) }
      it { should be_instance_of Array }
      it 'should return an array of assets' do
        page.assets.each { |asset| expect(asset).to be_instance_of Siteleaf::Asset }
      end
    end
    context 'when id is nil' do
      it 'should raise error for each_pair function in attributes function' do
        stub_request(:get, %r{pages\/\/assets\z}).to_return(body: ERROR, headers: { content_type: 'application/json' })
        expect { page.assets }.to raise_error NoMethodError
      end
    end
  end

  describe '#posts' do
    subject { page.posts }
    context 'when id is present' do
      let(:id) { PAGE_ID }
      before { stub_request(:get, %r{pages\/#{PAGE_ID}\/posts\z}).to_return(body: POSTS, headers: { content_type: 'application/json' }) }
      it { should be_instance_of Array }
      it 'should return an array of posts' do
        page.posts.each { |post| expect(post).to be_instance_of Siteleaf::Post }
      end
    end
    context 'when id is nil' do
      it 'should raise error for each_pair function in attributes function' do
        stub_request(:get, %r{pages\/\/posts\z}).to_return(body: ERROR, headers: { content_type: 'application/json' })
        expect { page.posts }.to raise_error NoMethodError
      end
    end
  end

  describe '#pages' do
    subject { page.pages }
    context 'when id is present' do
      let(:id) { PAGE_ID }
      before { stub_request(:get, %r{pages\/#{PAGE_ID}\?include=pages\z}).to_return(body: PAGE, headers: { content_type: 'application/json' }) }
      it { should be_instance_of Array }
      it 'should return an array of pages' do
        page.pages.each { |page| expect(page).to be_instance_of Siteleaf::Page }
      end
    end
    context 'when id is nil' do
      it 'should raise error for each_pair function in attributes function' do
        stub_request(:get, %r{pages\/\?include=pages\z}).to_return(body: ERROR, headers: { content_type: 'application/json' })
        expect { page.pages }.to raise_error TypeError
      end
    end
  end

  describe '#page' do
    subject { page.page }
    context 'when parent_id is present' do
      let(:parent_id) { PARENT_ID }
      before { stub_request(:get, %r{/pages\z}).to_return(body: PAGES, headers: { content_type: 'application/json' }) }
      it { should be_an_instance_of Siteleaf::Page }
    end
    context 'when parent_id is nil' do
      it { should eql nil }
    end
  end
end
