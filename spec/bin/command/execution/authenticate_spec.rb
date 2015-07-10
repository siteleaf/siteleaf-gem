require File.expand_path('../../../../spec_helper.rb', __FILE__)

describe 'Authenticate' do
  let(:authenticate) { Commands::Execution::Authenticate }

  describe '#self.authenticate' do
    subject { authenticate.authenticate }
    context '' do
      it '' do
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
    context '' do
      it '' do
        # Pending
      end
    end
  end

  describe '#self.auth' do
    subject { authenticate.auth }
    context '' do
      it '' do
        # Pending
      end
    end
  end
end
