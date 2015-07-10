require File.expand_path('../../../spec_helper.rb', __FILE__)

describe 'Commands' do
  let(:commands) { Commands }

  describe '#self.sever_command' do
    subject { commands.sever_command }
    context 'Siteleaf gem to run a localhost server to display the website locally' do
      it 'should start a localhost server' do
        # Pending
      end
    end
  end

  describe '#self.config_command' do
    subject { commands.config_command }
    context 'Siteleaf site is configured' do
      it 'should create a config.ru file in the current folder' do
        # Pending
      end
    end
  end

  describe '#self.new_command' do
    subject { commands.new_command }
    context 'A new site is created in siteleaf' do
      it 'should create a new empty site in siteleaf and a folder with a config.ru file' do
        # Pending
      end
    end
  end

  describe '#self.pull_command' do
    subject { commands.pull_command }
    context 'site assets are pulled from siteleaf' do
      it 'should download the theme assets to the clients machine' do
        # Pending
      end
    end
  end

  describe '#self.push_command' do
    subject { commands.push_command }
    context 'site assets are pushed to siteleaf' do
      it 'should upload the theme assets to the clients machine' do
        # Pending
      end
    end
  end

  describe '#self.publish_command' do
    subject { commands.publish_command }
    context 'Siteleaf site is published' do
      it 'should publish the configred site' do
        # Pending
      end
    end
  end
end
