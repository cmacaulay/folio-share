require 'twilio-ruby'

class TwilioService

  def initialize(cellphone, user)
    @cellphone = cellphone
    @user = user
  end

  def sms
    account_sid = "AC8f6311eacf052fb6aaab768834633f79"
    auth_token = "ee87b7bc10ab9de3136d3edbe38a4068"

    @client = Twilio::REST::Client.new account_sid, auth_token
    message = @client.account.messages.create(
      from: "+17207702071",
      to: "+17209826950",
      body: "Your reset code is #{@user.reset_token}"
      )
  end
end 