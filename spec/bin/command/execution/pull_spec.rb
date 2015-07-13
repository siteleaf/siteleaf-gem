require File.expand_path('../../../../spec_helper.rb', __FILE__)

describe 'Pull' do
  let(:pull) { Commands::Execution::Pull }

  describe '#self.read_asset_server' do
    subject { pull.read_asset_server }
    context 'reads a file from siteleaf server' do
      it 'should return the asset file from siteleaf' do
        # Pending
      end
    end
  end

  describe '#self.write_asset_local' do
    subject { pull.write_asset_local }
    context 'reads a file from the local machine' do
      it 'should return the asset file from possible the clients machine' do
        # Pending
      end
    end
  end

  describe '#self.asset_exists_and_checksum' do
    let(:asset) { Siteleaf::Asset.new }
    subject { pull.asset_exists_and_checksum }
    context 'Checks if the file is valid or not' do
      it 'should return a boolean value based up the assets existence and checksum' do
        asset.filename = 'Pass something'
        expect(pull.asset_exists_and_checksum(asset)).to be_falsey
      end
    end
  end

  describe '#self.get_theme_assets' do
    subject { pull.get_theme_assets }
    context 'Gets all the theme files' do
      it 'should download all the theme files to the clients machine' do
        # Pending
      end
    end
  end
end
