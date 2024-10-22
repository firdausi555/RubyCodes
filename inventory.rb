class Inventory
  #attr_accessor :items

  def initialize
    @items = {}
  end

  def add_item(name, price, quantity)
    if @items.key?(name)
      @items[name][:quantity] += quantity
    else
      @items[name] = { price: price, quantity: quantity }
    end
    puts "#{quantity} of #{name} added to inventory."
  end

  def remove_item(name, quantity)
    return puts "#{name} not found." unless @items.key?(name)

    if @items[name][:quantity] < quantity
      puts "Not enough #{name} in inventory to remove."
    else
      @items[name][:quantity] -= quantity
      puts "#{quantity} of #{name} removed from inventory."
      @items.delete(name) if @items[name][:quantity] == 0
    end
  end

  def show_inventory
    if @items.empty?
      puts "The inventory is empty."
    else
      puts "Current Inventory:"
      @items.each do |name, details|
        puts "#{name}: Price = Rs#{details[:price]}, Quantity = #{details[:quantity]}"
      end
    end
  end

  def generate_bill(purchases)
    total = 0
    puts "\nYour Purchase:"
    purchases.each do |name, quantity|
      if @items.key?(name) && @items[name][:quantity] >= quantity
        item_total = @items[name][:price] * quantity
        total += item_total
        puts "#{name}: #{quantity} x Rs#{@items[name][:price]} = Rs#{item_total}"
      else
        puts "Not enough quantity for #{name}."
      end
    end
    puts "Total Amount to be paid : Rs#{total}"
  end
end

def main
  inventory = Inventory.new

  loop do
    puts "\nSelect from the following to do the operations: "
    puts "1. Add Item"
    puts "2. Remove Item"
    puts "3. Show Inventory"
    puts "4. Generate Bill"
    puts "5. Exit"
    print "Choose an option: "
    choice = gets.chomp.to_i

    case choice
    when 1
      print "Enter item name: "
      name = gets.chomp
      print "Enter item price: "
      price = gets.chomp.to_f
      print "Enter quantity: "
      quantity = gets.chomp.to_i
      inventory.add_item(name, price, quantity)
    when 2
      print "Enter item name: "
      name = gets.chomp
      print "Enter quantity to remove: "
      quantity = gets.chomp.to_i
      inventory.remove_item(name, quantity)
    when 3
      inventory.show_inventory
    when 4
      purchases = {}
      loop do
        print "Enter item name to purchase (or type 'done' to finish): "
        name = gets.chomp
        break if name.downcase == 'done'
        print "Enter quantity: "
        quantity = gets.chomp.to_i
        purchases[name] = quantity
      end
      inventory.generate_bill(purchases)
    when 5
      puts "Exiting..."
      break
    else
      puts "Invalid option, please try again."
    end
  end
end

main