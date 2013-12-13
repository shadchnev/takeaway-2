require "sendtext"

class Takeaway 

  include SendText # this class never uses the method send from this module 

  # You seem to have all the bits and pieces but you expect the code that
  # uses this class to call all methods independently. Instead, it would be
  # easier if you had one method like place_order(order, total) that would 
  # add all items, check the payment and send the text
  
  MENU = { food: "pizza", price: 9.00 }, 
    { food: "chips", price: 3.00 },
    { food: "wedges", price: 3.00 },
    { food: "chicken wings", price: 4.50 }

  attr_accessor :menu, :order, :subtotal, :complete

  def initialize
    @menu = MENU # no need for this, just use the constant
    @order = []
    @subtotal = [] 
    @complete = false
    @delivery_time = Time.now + (3600)
  end
  
  def place_order item
    order << item
    add_price_to_subtotal item
  end

  def add_price_to_subtotal item
    dish = MENU.detect {|dish| dish[:food] == item}
    subtotal << dish[:price] if dish
  end

  def total_price
    subtotal.inject(:+) # cool
  end

  def complete_order
    order.clear
    subtotal.clear
  end

  def complete?
    order.empty? && subtotal.empty?
    self.complete = true # so, the method always returns true?
  end

  # Bad name for a method. It doesn't process a payment, it merely raises an error  
  def pay amount
    raise "Where's the rest of my money foo?!?!" if amount < total_price
  end

end
