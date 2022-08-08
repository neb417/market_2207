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
    # vendor_list = []
    # @vendors.each do |vendor|
    #  vendor_list << vendor if vendor.inventory.include?(item)
    # binding.pry
    # end
    # vendor_list
    @vendors.select do |vendor|
      vendor.inventory.keys.include?(item)
    end
  end

  def total_inventory
    total_inventory = Hash.new{|item, name| item[name] = {quantity: 0, vendors: []}}

    @vendors.map do |vendor|
      vendor.inventory.map do |item, qty|
        total_inventory[item][:quantity] += qty
        total_inventory[item][:vendors] << vendor
      end
    end
    total_inventory
  end

  def overstocked_items
    total_inventory.reduce([]) do |overstocked, (item, info)|
      overstocked << item if info[:quantity] > 50 && info[:vendors].count > 1
      overstocked
    end
  end

  def sorted_item_list
    @vendors.flat_map do |vendor|
      vendor.inventory.keys.map do |item|
        item.name
      end
    end.sort.uniq
  end
end
