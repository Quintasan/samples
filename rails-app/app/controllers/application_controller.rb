class ApplicationController < ActionController::API
  Success = Dry::Monads::Result::Success
  Failure = Dry::Monads::Result::Failure
end
