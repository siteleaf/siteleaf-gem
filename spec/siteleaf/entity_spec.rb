require File.expand_path('../../spec_helper.rb', __FILE__)

describe 'Entity' do
  let(:id) { nil }
  let(:attributes) { { id: id } }
  let(:entity) { Siteleaf::Entity }
  let(:asset) { Siteleaf::Asset }
  let(:page) { Siteleaf::Page }
  let(:post) { Siteleaf::Post }
  let(:theme) { Siteleaf::Theme }
  let(:site) { Siteleaf::Site }
  let(:user) { Siteleaf::User }

  describe '#initialize' do
    subject { entity.new }
    context 'when entity is initialized' do
      it { should be_an_instance_of Siteleaf::Entity }
    end
  end

  describe '#self.all' do
    subject(:post_all) { post.all }
    subject(:page_all) { page.all }
    subject(:asset_all) { asset.all }
    subject(:user_all) { user.all }
    subject(:site_all) { site.all }
    it 'returns array of Siteleaf objects of that instance' do
      stub_request(:get, %r{\/posts\z}).to_return(body: POSTS, headers: { content_type: 'application/json' })
      stub_request(:get, %r{\/pages\z}).to_return(body: PAGES, headers: { content_type: 'application/json' })
      stub_request(:get, %r{\/assets\z}).to_return(body: ASSETS, headers: { content_type: 'application/json' })
      stub_request(:get, %r{\/users\z}).to_return(body: USERS, headers: { content_type: 'application/json' })
      stub_request(:get, %r{\/sites\z}).to_return(body: SITES, headers: { content_type: 'application/json' })
      expect(post_all).to be_an_instance_of Array
      expect(page_all).to be_an_instance_of Array
      expect(asset_all).to be_an_instance_of Array
      expect(user_all).to be_an_instance_of Array
      expect(site_all).to be_an_instance_of Array
      post_all.each { |post| expect(post).to be_an_instance_of Siteleaf::Post }
      page_all.each { |page| expect(page).to be_an_instance_of Siteleaf::Page }
      asset_all.each { |asset| expect(asset).to be_an_instance_of Siteleaf::Asset }
      user_all.each { |user| expect(user).to be_an_instance_of Siteleaf::User }
      site_all.each { |site| expect(site).to be_an_instance_of Siteleaf::Site }
    end
  end

  describe '#self.find' do
    subject(:post_find) { post.find(POST_ID) }
    subject(:page_find) { page.find(PAGE_ID) }
    subject(:asset_find) { asset.find(ASSET_ID) }
    subject(:user_find) { user.find(USER_ID) }
    subject(:site_find) { site.find(SITE_ID) }
    it 'returns a Siteleaf object of that instance if parameter is passed' do
      expect(post_find).to be_an_instance_of Siteleaf::Post
      expect(page_find).to be_an_instance_of Siteleaf::Page
      expect(asset_find).to be_an_instance_of Siteleaf::Asset
      expect(user_find).to be_an_instance_of Siteleaf::User
      expect(site_find).to be_an_instance_of Siteleaf::Site
    end
  end

  describe '#self.create' do
    subject(:post_create) { post.create }
    subject(:page_create) { page.create }
    subject(:asset_create) { asset.create }
    subject(:user_create) { user.create }
    subject(:site_create) { site.create }
    it 'returns a Siteleaf object of that instance if parameter is passed' do
      expect(post_create).to be_an_instance_of Siteleaf::Post
      expect(page_create).to be_an_instance_of Siteleaf::Page
      expect(asset_create).to be_an_instance_of Siteleaf::Asset
      expect(user_create).to be_an_instance_of Siteleaf::User
      expect(site_create).to be_an_instance_of Siteleaf::Site
    end
  end

  describe '#save' do
    subject(:post_save) { post.new(attributes).save }
    subject(:page_save) { page.new(attributes).save }
    subject(:asset_save) { asset.new(attributes).save }
    subject(:user_save) { user.new(attributes).save }
    subject(:site_save) { site.new(attributes).save }
    it 'returns a Siteleaf object if siteleaf object exists' do
      expect(post_save).to be_an_instance_of Siteleaf::Post
      expect(page_save).to be_an_instance_of Siteleaf::Page
      expect(asset_save).to be_an_instance_of Siteleaf::Asset
      expect(user_save).to be_an_instance_of Siteleaf::User
      expect(site_save).to be_an_instance_of Siteleaf::Site
    end
  end

  describe '#attributes' do
    subject { entity.new.attributes }
    context 'when Entity is initialized a Hash is made for their attributes' do
      # No Need to check this function for the other objects as it just returns the same output
      it { should eql({}) }
    end
  end

  describe '#attributes=' do
    subject { entity.new.attributes = attributes }
    context 'when Entity is initialized it is allocated the attributes passed .new(attributes)' do
      # No Need to check this function for the other objects as it just returns the same output
      it { should eql attributes }
    end
  end

  describe '#self.class_name' do
    subject(:entity_class_name) { entity.class_name }
    subject(:post_class_name) { post.class_name }
    subject(:page_class_name) { page.class_name }
    subject(:asset_class_name) { asset.class_name }
    subject(:user_class_name) { user.class_name }
    subject(:site_class_name) { site.class_name }
    subject(:theme_class_name) { theme.class_name }
    it 'returns Class name of Object' do
      expect(entity_class_name).to match 'Entity'
      expect(post_class_name).to match 'Post'
      expect(page_class_name).to match 'Page'
      expect(asset_class_name).to match 'Asset'
      expect(user_class_name).to match 'User'
      expect(site_class_name).to match 'Site'
      expect(theme_class_name).to match 'Theme'
    end
  end

  describe '#self.endpoint' do
    subject(:entity_endpoint) { entity.endpoint }
    subject(:user_endpoint) { user.endpoint }
    subject(:theme_endpoint) { theme.endpoint }
    it 'adds s to lower case of class name' do
      expect(entity_endpoint).to match 'entitys'
      expect(user_endpoint).to match 'users'
      expect(theme_endpoint).to match 'themes'
    end
  end

  describe '#self.create_endpoint' do
    subject(:entity_create_endpoint) { entity.new.create_endpoint }
    subject(:user_create_endpoint) { user.new.create_endpoint }
    subject(:theme_create_endpoint) { theme.new.create_endpoint }
    it 'adds s to lower case of class name' do
      expect(entity_create_endpoint).to match 'entitys'
      expect(user_create_endpoint).to match 'users'
      expect(theme_create_endpoint).to match 'themes'
    end
  end
end
