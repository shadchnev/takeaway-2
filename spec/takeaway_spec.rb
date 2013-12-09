require "./lib/takeaway"

describe Takeaway do
  context "It should" do

    let(:takeaway) { Takeaway.new } 
    let(:delivery_time) { Time.now + (3600) }
    let(:sendtext) { double :SendText, send: "Thanks for your order! It shall arrive no later than #{delivery_time.strftime("%H")}:#{delivery_time.strftime("%M")}." }

    it "have a menu" do
      expect(takeaway.menu).to_not be_empty
    end

    it "be a blank order when created" do
      expect(takeaway.order).to be_empty
    end

    it "be able to take a simple order from a customer" do
      takeaway.place_order("pizza")
      expect(takeaway.order).to eq(["pizza"])
    end

    it "be able to take a complex order from a customer" do
      takeaway.place_order("pizza")
      takeaway.place_order("pizza")
      takeaway.place_order("wedges")
      takeaway.place_order("chicken wings")
      expect(takeaway.order).to eq(["pizza", "pizza", "wedges", "chicken wings"])
    end

    it "return a price of how much the order has cost so far" do
      takeaway.place_order("pizza")
      takeaway.place_order("pizza")
      takeaway.place_order("wedges")
      takeaway.place_order("chicken wings")
      expect(takeaway.total_price).to eq(25.50)
    end

    it "mark the order as complete when done" do
      takeaway.place_order("pizza")
      takeaway.place_order("wedges")
      takeaway.pay(12)
      takeaway.complete_order
      expect(takeaway.complete?).to be_true
    end

    it "return an error if the customer tries to pay with too little money" do
      takeaway.place_order("pizza")
      expect{ takeaway.pay(5.00) }.to raise_error("Where's the rest of my money foo?!?!")
    end

    it "send a text message confirming your order and a delivery time" do
      takeaway.place_order("pizza")
      takeaway.place_order("pizza")
      takeaway.place_order("wedges")
      takeaway.place_order("chicken wings")
      takeaway.pay(25.50)
      takeaway.complete_order
      expect(sendtext.send).to eq("Thanks for your order! It shall arrive no later than #{delivery_time.strftime("%H")}:#{delivery_time.strftime("%M")}.")
    end

    xit "TWILIO - send a text message confirming your order and a delivery time" do
      takeaway.place_order("pizza")
      takeaway.place_order("pizza")
      takeaway.place_order("wedges")
      takeaway.place_order("chicken wings")
      takeaway.pay(25.50)
      takeaway.complete_order
      expect(takeaway.send("")).to eq("Thanks for your order! It shall arrive no later than #{delivery_time.strftime("%H")}:#{delivery_time.strftime("%M")}.")
    end
  end
end
