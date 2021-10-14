require 'dry/validation'

class NewUserContract < Dry::Validation::Contract
  SUPPORTED_COUNTRIES = %w[pl en de ru]

  params do
    required(:email).filled(:string)
    required(:password).filled(:string)
    required(:password_confirmation).filled(:string)
    required(:country).filled(:string)
    required(:age).value(:integer)
  end

  rule(:email) do
    unless /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.match?(value)
      key.failure('is not a valid email address')
    end
  end

  rule(:password, :password_confirmation) do
    unless values[:password] == values[:password_confirmation]
      key.failure('passwords must match')
    end
  end

  rule(:country) do
    unless SUPPORTED_COUNTRIES.include?(value)
      key.failure('is not one of the supported countries')
    end
  end
end
