require File.expand_path('../../../../spec_helper.rb', __FILE__)

describe 'Common' do
  let(:common) { Commands::Execution::Common }

  describe '#self.fetch_site_id_config' do
    subject { common.fetch_site_id_config }
    context 'fetches the site id from the config.ru file' do
      it 'should either return the site id or nil but in this instance it is nil' do
        expect(common.fetch_site_id_config).to be_nil
      end
    end
  end

  describe '#self.authenticated?' do
    subject { common.authenticated? }
    context 'checks if the user is authenticated or not?' do
      it 'returns true if not authenticated and vice-versa' do
        # pending
      end
    end
  end

  describe '#self.site_configured?' do
    subject { common.site_configured? }
    context 'checks if the site is configured or not i.e. checks for the config.ru file' do
      it 'should return a boolean and this case it will be false' do
        expect(common.site_configured?).to be_falsey
      end
    end
  end

  describe '#self.configure_site' do
    subject { common.configure_site }
    context 'must configgure a site' do
      it 'should configure the site using the site id' do
        # Pending
      end
    end
  end
end
