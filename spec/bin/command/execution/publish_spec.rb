require File.expand_path('../../../../spec_helper.rb', __FILE__)

describe 'Publish' do
  let(:publish) { Commands::Execution::Publish }

  describe '#self.do_the_job' do
    subject { publish.do_the_job }
    context 'prints the message for the job' do
      it 'should print till the last job' do
        # Pending
      end
    end
  end

  describe '#self.publish' do
    subject { publish.publish }
    context 'Publishes the site' do
      it 'shoul publish the site on the internet' do
        # Pending
      end
    end
  end
end
