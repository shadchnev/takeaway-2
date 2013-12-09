require "twilio-ruby"

module SendText

  TAKEAWAY_NUMBER = ENV["TWILIO_PHONE_NUMBER"]
  ACCOUNT_SID = ENV["TWILIO_ACCOUNT_SID"] 
  AUTH_TOKEN = ENV["TWILIO_AUTH_TOKEN"]
  CLIENT = Twilio::REST::Client.new ACCOUNT_SID, AUTH_TOKEN 

  def send phone_number
    account = CLIENT.account
    message = account.sms.messages.create({from: TAKEAWAY_NUMBER , to: phone_number, body: "Thanks for your order! It shall arrive no later than #{@delivery_time.strftime("%H")}:#{@delivery_time.strftime("%M")}."})
    message.body
  end

end
