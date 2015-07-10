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
    context '' do
      it '' do
        # Pending
      end
    end
  end

  describe '#self.auth_error' do
    subject { authenticate.auth_error }
    context '' do
      it '' do
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