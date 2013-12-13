require "twilio-ruby"

module SendText

  TAKEAWAY_NUMBER = ENV["TWILIO_PHONE_NUMBER"]
  ACCOUNT_SID = ENV["TWILIO_ACCOUNT_SID"] 
  AUTH_TOKEN = ENV["TWILIO_AUTH_TOKEN"]
  # your tests fail because of this line if I don't have these env vars
  # The tests should always pass out of the box
  CLIENT = Twilio::REST::Client.new ACCOUNT_SID, AUTH_TOKEN 

  # If you tested this code, you'd find that it fails.  
  def send phone_number
    account = CLIENT.account 
    message = account.sms.messages.create({from: TAKEAWAY_NUMBER , to: phone_number, body: "Thanks for your order! It shall arrive no later than #{@delivery_time.strftime("%H")}:#{@delivery_time.strftime("%M")}."})
    message.body
  end

end
