# This is a class stub that usually would be implemented by ActiveMailer

ConfirmationEmail = Struct.new(:name) do
  def deliver_later
    puts "Sending to Sidekiq..."
  end
end

class UserMailer
  class << self
    def with(user:)
      UserMailer.new(user)
    end
  end

  def initialize(user)
    @user = user
  end

  def confirmation_email
    ConfirmationEmail.new(@user.email)
  end
end
