require('pry-byebug')
require_relative('models/property.rb')

property1 = Property.new({"address" => "1 Castle Road", "value" => 10, "number_of_bedrooms" => 20, "buy_status" => true})

property2 = Property.new({"address" => "2 Castle Road", "value" => 30, "number_of_bedrooms" => 50, "buy_status" => false})


property1.save()
property2.save()

Property.delete_all

property2.delete()

# p property1
# p property2

p Property.all()
