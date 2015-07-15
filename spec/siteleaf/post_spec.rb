require File.expand_path('../../spec_helper.rb', __FILE__)

describe 'Post' do
  let(:id) { nil }
  let(:parent_id) { nil }
  let(:attributes) do
    {
      id: id,
      parent_id: parent_id
    }
  end
  let(:post) { Siteleaf::Post.new(attributes) }

  describe '#create_endpoint' do
    subject { post.create_endpoint }
    context 'when parent_id is present' do
      let(:parent_id) { ENV['PARENT_ID'] }
      it { should eql 'pages/PARENT_ID/posts' }
    end
    context 'when parent_id is nil' do
      it { should eql 'pages//posts' }
    end
  end

  describe '#parent' do
    subject { post.parent }
    context 'Must always return a parent Object' do
      it { should be_an_instance_of Siteleaf::Page }
    end
  end

  describe '#assets', vcr: { cassette_name: 'post_assets', record: :none } do
    subject { post.assets }
    context 'when id is present' do
      let(:id) { ENV['POST_ID'] }
      it 'should return an array of assets' do
        post.assets.each do |asset|
          expect(asset).to be_instance_of(Siteleaf::Asset)
        end
      end
    end
  end
end
