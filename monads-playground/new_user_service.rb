require 'pry-byebug'
require_relative './base_service'
require_relative './new_user_contract'
require_relative './user_mailer'

class User
  attr_accessor :email, :password, :invalid

  def initialize(email, password, invalid = false)
    @email = email
    @password = password
    @invalid = invalid
  end

  def self.create(params)
    p = params.slice(:email, :password, :invalid)
    User.new(*p.values)
  end

  def valid?
    return false if invalid

    true
  end
end

class NewUserService < BaseService
  def call(params)
    params = yield validate_params(params)
    user = yield create_user(params)
    yield send_confirmation_email(user)

    Success(user)
  end

  private

  def contract
    NewUserContract.new
  end

  def validate_params(params)
    validation = contract.call(params)

    if validation.success?
      Success(validation.to_h)
    else
      Failure(validation.errors.to_h)
    end
  end

  def create_user(params)
    user = User.create(
      email: params[:email],
      password: params[:password],
      country: params[:country],
      age: params[:age]
    )
    return Failure(user.errors) unless user.valid?

    Success(user)
  end

  def send_confirmation_email(user)
    UserMailer.with(user: user).confirmation_email.deliver_later
    Success(:delivered)
  end
end
