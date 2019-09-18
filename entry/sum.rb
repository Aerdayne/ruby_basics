def parse(cart)
    subtotal = []
    puts 'Cart contents:'
    cart.each do |name, hash|
        print "Name: #{name}".ljust(20)
        hash.each do |key, value|
            print "Price: #{key}".ljust(20)
            print "Quantity: #{value}".ljust(20)
            subtotal.push (key * value)
            print "Subtotal: #{subtotal[-1]}".ljust(10)
        end
        puts
    end
    puts "Total price: #{subtotal.inject(0){|total,sub|total + sub}}"
end

puts 'Enter the product name, price and amount purchased.'
cart = {}
loop do
    puts 'Product name: (type STOP if you are done)'
    name = gets.chomp
    break if name.downcase == 'stop'
    puts 'Product price:'
    price = gets.chomp
    price = Float(price)
    puts 'Product quantity:'
    quantity = gets.chomp
    quantity = Float(quantity)
    cart[name] = {price => quantity}
rescue ArgumentError
    puts "Input should be numeric"
retry
end
parse(cart)
