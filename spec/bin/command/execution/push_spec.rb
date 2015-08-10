require File.expand_path('../../../../spec_helper.rb', __FILE__)

describe 'Push' do
  let(:push) { Commands::Execution::Push }

  describe '#self.theme' do
    subject { push.theme }
    context 'returns the theme of the respective site' do
      it 'should return the theme of the corresponding site_id passed to it' do
        expect(push.theme('Some Site ID')).to be_instance_of(Siteleaf::Theme)
      end
    end
  end

  describe '#self.create_asset' do
    subject { push.create_asset }
    context 'Creates an asset in the respective site' do
      it 'should create an asset in the corresponding site or throw an error' do
        # pending
      end
    end
  end

  describe '#self.file_valid?' do
    subject { push.file_valid? }
    context 'Checks if the file is valid or not' do
      it 'should return a boolean value based up the files existence' do
        # path is left blank but the config.ru is something that will always exist
        expect(push.file_valid?('', ['config.ru'])).to be_truthy
      end
    end
  end

  describe '#self.assets_find' do
    subject { push.assets_find }
    context 'finds the corresponding asset in the' do
      it 'should return the found asset in the site' do
        # pending
      end
    end
  end

  describe '#self.asset_valid?' do
    subject { push.asset_valid? }
    context 'Checks if the asset is valid or not' do
      it 'should return a boolean value based up the assets existence and checksum' do
        expect(push.asset_valid?(nil, nil)).to be_truthy
      end
    end
  end

  describe '#self.upload_assets' do
    subject { push.upload_assets }
    context 'uploads the asset onto siteleaf' do
      it 'should upload all the new or updated assets and update the updated_count' do
        # Pending
      end
    end
  end

  describe '#self.get_missing_assets' do
    subject { push.get_missing_assets }
    context 'gets the assets that are on siteleaf but do not reside in your local directory' do
      it 'should return an array of assets that are not found in your local project' do
        expect(push.get_missing_assets([])).to be_empty
      end
    end
  end

  describe '#self.delete_missing_assets' do
    subject { push.delete_missing_assets }
    context 'gets the missing assets and deletes them one by one' do
      it 'should print the assets being deleted' do
        # Pending
      end
    end
  end

  describe '#self.cleanup_old_assets' do
    subject { push.cleanup_old_assets }
    context 'Gets the missing assets and deletes these assets' do
      it 'should return the new updated_count after deleting the missing assets' do
        # Pending
      end
    end
  end

  describe '#self.put_theme_assets' do
    subject { push.put_theme_assets }
    context 'facilitates the entire strategy if pushing assets from the local directory to siteleaf' do
      it 'should push the assets to siteleaf' do
        # Pending
      end
    end
  end
end
