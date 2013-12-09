require "sendtext"

class Takeaway 

  include SendText
  
  MENU = { food: "pizza", price: 9.00 }, 
    { food: "chips", price: 3.00 },
    { food: "wedges", price: 3.00 },
    { food: "chicken wings", price: 4.50 }

  attr_accessor :menu, :order, :subtotal, :complete

  def initialize
    @menu = MENU 
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
    MENU.each do |hash|
      subtotal << hash[:price] if hash[:food] == item
    end
  end

  def total_price
    subtotal.inject(:+)
  end

  def complete_order
    order.clear
    subtotal.clear
  end

  def complete?
    order.empty? && subtotal.empty?
    self.complete = true
  end

  def pay amount
    raise "Where's the rest of my money foo?!?!" if amount < total_price
  end

end
