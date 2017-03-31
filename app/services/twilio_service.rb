require 'twilio-ruby'

class TwilioService

  def initialize(cellphone, user)
    @cellphone = cellphone
    @user = user
  end

  def sms
    account_sid = ENV['twilio_sid']
    auth_token = ENV['twilio_token']

    @client = Twilio::REST::Client.new account_sid, auth_token
    message = @client.account.messages.create(
      from: "+17207702071",
      to: @cellphone
      body: "Your reset code is #{@user.reset_token}"
    )
  end
end