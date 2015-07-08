require File.expand_path('../../spec_helper.rb', __FILE__)

describe 'Post' do
  let(:post) { Siteleaf::Post.new }

  describe '#create_endpoint' do
    subject { post.create_endpoint }
    context 'post API URL Postfix' do
      it 'should end with post' do
        expect(post.create_endpoint).to end_with('posts')
      end
    end
  end

  describe '#parent' do
    subject { post.site }
    context 'Get the page ID to which that post belongs to' do
      it 'should return parent page id' do
        expect(post.site).to be_nil
      end
    end
  end

  describe '#assets', vcr: { cassette_name: 'post_assets', record: :none } do
    subject { post.assets }
    context 'Get post assets' do
      it 'should return an array of post assets' do
        expect(post.assets).to be_empty
      end
    end
  end
end
