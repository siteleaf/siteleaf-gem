require File.expand_path('../../../../spec_helper.rb', __FILE__)

describe 'Authenticate' do
  let(:authenticate) { Commands::Execution::Authenticate }

  describe '#self.authenticate' do
    subject { authenticate.authenticate }
    context 'Takes in user iput for key and Secret and validates it' do
      it 'should authenticate the user with the email and password provided by the user' do
        # Pending
      end
    end
  end

  describe '#self.authenticate_write_file' do
    subject { authenticate.authenticate_write_file }
    context 'is called when user is Authenticated' do
      it 'should Marshal.dump Key and secret  to a local `~/.siteleaf file' do
        # Pending
      end
    end
  end

  describe '#self.auth_error' do
    subject { authenticate.auth_error }
    context 'is called when user faces Authentication error' do
      it 'should return false and print an error statement' do
        expect(authenticate.auth_error).to be_falsey
      end
    end
  end

  describe '#self.authenticate_true' do
    subject { authenticate.authenticate_true }
    context 'if the user has already been authenticated then it should return true' do
      it 'should return true if the user is has already been authenticated' do
        # Pending
      end
    end
  end

  describe '#self.auth' do
    subject { authenticate.auth }
    context 'Facilitates the enitire Authentication Process' do
      it 'Should authenticate the user using the provided key and secret' do
        # Pending
      end
    end
  end
end
