require 'spec_helper'
require_relative '../new_user_contract'

RSpec.describe NewUserContract do
  subject { described_class.new.call(params) }

  context 'with valid data' do
    let(:params) do
      {
        email: "test@email.com",
        password: "supersecret256",
        password_confirmation: "supersecret256",
        country: "pl",
        age: 21
      }
    end

    it 'passes' do
      expect(subject).to be_success
    end
  end

  context 'with invalid data' do
    let(:params) {}

    it 'fails' do
      expect(subject).to be_failure
    end
  end
end
