require 'dry/monads'

class BaseService
  include Dry::Monads[:result, :do]

  class AbstractMethodNotImplemented < StandardError; end

  def contract
    raise AbstractMethodNotImplemented
  end
end
