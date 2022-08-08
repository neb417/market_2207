require 'pry'
class Market
  attr_reader :name, :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendors_names
    @vendors.map do |vendor|
      vendor.name
    end
  end

  def vendors_that_sell(item)
    vendor_list = []
    
    @vendors.each do |vendor|
     vendor_list << vendor if vendor.inventory.include?(item)
    end
    vendor_list
    # binding.pry
  end
end
