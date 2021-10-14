class ApplicationService
  class AbstractMethodNotImplemented < StandardError; end

  include Dry::Monads[:result, :do]

  protected

  def contract
    raise AbstractMethodNotImplemented
  end
end
