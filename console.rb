require('pry-byebug')
require_relative('models/property.rb')
Property.delete_all()

property1 = Property.new({"address" => "1 Castle Road", "value" => 10, "number_of_bedrooms" => 20, "buy_status" => true})

property2 = Property.new({"address" => "2 Castle Road", "value" => 30, "number_of_bedrooms" => 50, "buy_status" => false})


property1.save()
property2.save()


# property2.delete()
property1.value = 3
property1.update()
# p Property.find(54)

p Property.find_by_address('1 Castle Road')
p Property.find_by_address('3 Castle Road')
# p property1
# p property2

# p Property.all()
