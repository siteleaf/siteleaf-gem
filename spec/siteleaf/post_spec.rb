require File.expand_path('../../spec_helper.rb', __FILE__)

describe 'Post' do
  let(:id) { nil }
  let(:parent_id) { nil }
  let(:attributes) { { id: id, parent_id: parent_id } }
  let(:post) { Siteleaf::Post.new(attributes) }

  describe '#create_endpoint' do
    subject { post.create_endpoint }
    context 'when parent_id is present' do
      let(:parent_id) { ENV['PARENT_ID'] }
      it { should eql "pages/#{ENV['PARENT_ID']}/posts" }
    end
    context 'when parent_id is nil' do
      it { should eql 'pages//posts' }
    end
  end

  describe '#parent' do
    subject { post.parent }
    context 'when parent_id is present' do
      let(:parent_id) { ENV['PARENT_ID'] }
      it { should be_an_instance_of Siteleaf::Page }
    end
    context 'when parent_id is nil' do
      it 'should raise error for each_pair function in attributes function' do
        expect { post.assets }.to raise_error NoMethodError
      end
    end
  end

  describe '#assets' do
    before do
      stub_request(:get, %r{posts\/#{ENV['POST_ID']}\/assets\z}).to_return(body: ENV['assets'], headers: { content_type: 'application/json' })
      stub_request(:get, %r{posts\/\/assets\z}).to_return(body: ENV['error'], headers: { content_type: 'application/json' })
    end
    subject { post.assets }
    context 'when id is present' do
      let(:id) { ENV['POST_ID'] }
      it { should be_an_instance_of Array }
      it 'should return an array of assets' do
        post.assets.each { |asset| expect(asset).to be_instance_of(Siteleaf::Asset) }
      end
    end
    context 'when id is nil' do
      it 'should raise error for each_pair function in attributes function' do
        expect { post.assets }.to raise_error NoMethodError
      end
    end
  end
end
