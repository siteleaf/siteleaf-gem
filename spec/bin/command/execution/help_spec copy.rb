require File.expand_path('../../../../spec_helper.rb', __FILE__)

describe 'Help' do
  let(:help) { Commands::Execution::Help }

  describe '#self.help_commands' do
    subject { help.help_commands }
    context 'has all the siteleaf commands' do
      it 'should return text containing doc on all the commands for the commandline-tool' do
        # Not needed
      end
    end
  end

  describe '#self.help_options' do
    subject { help.help_options }
    context 'has all the siteleaf options' do
      it 'should return text containing doc on all the options for the commandline-tool' do
        # Not needed
      end
    end
  end

  describe '#self.help' do
    subject { help.help }
    context 'has collection of both commands and options' do
      it 'must return commands and options collectively' do
        expect(help.help).to include(help.help_commands)
        expect(help.help).to include(help.help_options)
      end
    end
  end
end
