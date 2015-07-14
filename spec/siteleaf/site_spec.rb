require File.expand_path('../../spec_helper.rb', __FILE__)

describe 'Site' do

  let(:id) { nil }
  let(:attributes) do
    {
      id: id
    }
  end
  let(:site) { Siteleaf::Site.new(attributes) }

  describe '#theme' do
    subject { site.theme }
    context 'Always returns theme for the site' do
      it { should be_an_instance_of Siteleaf::Theme }
    end
  end

  describe '#assets', vcr: { cassette_name: 'site_assets', record: :none } do
    subject { site.assets }
    context 'when id is present and site has assets' do
      let(:id) { ENV['SITELEAF_ID'] }
      it 'should return an array of assets' do
        site.assets.each do |asset|
          expect(asset).to be_instance_of(Siteleaf::Asset)
        end
      end
    end
  end

  describe '#pages', vcr: { cassette_name: 'site_pages', record: :none } do
    subject { site.pages }
    context 'when id is present' do
      let(:id) { ENV['SITELEAF_ID'] }
      it 'should return an array of pages' do
        site.assets.each do |asset|
          expect(asset).to be_instance_of(Siteleaf::Asset)
        end
      end
    end
  end

  describe '#posts', vcr: { cassette_name: 'site_posts', record: :none } do
    subject { site.posts }
    context 'Get all the site posts using the site_id' do
      it 'should return an array of posts or nil if no post declared' do
        expect(site.posts[0]).to be_instance_of(Siteleaf::Post)
      end
    end
  end
end
