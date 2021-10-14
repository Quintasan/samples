require 'spec_helper'
require_relative '../new_user_service'

RSpec.describe NewUserService do
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

    before do
      expect(UserMailer).to receive_message_chain(:with, :confirmation_email, :deliver_later)
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
