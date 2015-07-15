require File.expand_path('../../spec_helper.rb', __FILE__)

describe 'Site' do
  let(:id) { nil }
  let(:attributes) { { id: id } }
  let(:site) { Siteleaf::Site.new(attributes) }

  describe '#theme' do
    subject { site.theme }
    context 'Always returns an Object of Theme for the site or a new Theme Object if no site defined' do
      it { should be_an_instance_of Siteleaf::Theme }
    end
  end

  describe '#assets', vcr: { cassette_name: 'site_assets', record: :none } do
    subject { site.assets }
    context 'when id is present' do
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
        site.pages.each do |page|
          expect(page).to be_instance_of(Siteleaf::Page)
        end
      end
    end
  end

  describe '#posts', vcr: { cassette_name: 'site_posts', record: :none } do
    subject { site.posts }
    context 'when id is present' do
      let(:id) { ENV['SITELEAF_ID'] }
      it 'should return an array of posts' do
        site.posts.each do |post|
          expect(post).to be_instance_of(Siteleaf::Post)
        end
      end
    end
  end
end
