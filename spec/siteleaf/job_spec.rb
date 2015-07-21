require File.expand_path('../../spec_helper.rb', __FILE__)

describe 'Job' do
  let(:id) { nil }
  let(:attributes) { { id: id } }
  let(:job) { Siteleaf::Job.new(attributes) }

  describe '#stream' do
    subject { job.stream }
    context 'when id is present' do
      let(:id) { 'id' }
      # pending
    end
    context 'when id is nil' do
      # pending
    end
  end
end
