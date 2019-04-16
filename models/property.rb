require('pg')


class Property

  attr_accessor :address, :value, :number_of_bedrooms, :buy_status
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @address = options['address']
    @value = options['value'].to_i
    @number_of_bedrooms = options['number_of_bedrooms'].to_i
    @buy_status = options['buy_status']
  end


  def save()
    db = PG.connect({dbname: "properties", host: "localhost"})
    sql = "INSERT INTO properties (address, value, number_of_bedrooms, buy_status) VALUES ($1, $2, $3, $4) RETURNING id;"
    values = [@address, @value, @number_of_bedrooms, @buy_status]
    db.prepare("save", sql)
    properties_hashes = db.exec_prepared("save", values)
    @id = properties_hashes[0]['id']
    db.close()
  end

  def delete()
    db = PG.connect({dbname: "properties", host: "localhost"})
    sql = "DELETE FROM properties WHERE id = $1;"
    values = [@id]
    db.prepare("delete", sql)
    db.exec_prepared("delete", values)
    db.close()
  end

  def update()
    db = PG.connect({dbname: "properties", host: "localhost"})
    sql = "UPDATE properties SET (address, value, number_of_bedrooms, buy_status) = ($1, $2, $3, $4) WHERE id = $5;"
    values = [@address, @value, @number_of_bedrooms, @buy_status, @id]
    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close()
  end

  def Property.find(id)
    db = PG.connect({dbname: "properties", host: "localhost"})
    sql = "SELECT * FROM properties WHERE id = $1;"
    values = [id]
    db.prepare("find", sql)
    hash = db.exec_prepared("find", values)
    property = hash.map { |property_hash| Property.new(property_hash) }
    db.close()
    return property
  end

  def Property.find_by_address(address)
    db = PG.connect({dbname: "properties", host: "localhost"})
    sql = "SELECT * FROM properties WHERE address = $1;"
    values = [address]
    db.prepare("find", sql)
    hash = db.exec_prepared("find", values)
    property = hash.map { |property_hash| Property.new(property_hash) }
    db.close()
    if property == []
      return nil
    else
      return property
    end
  end

  def Property.all()
    db = PG.connect({dbname: "properties", host: "localhost"})
    sql = "SELECT * FROM properties;"
    properties_hashes = db.exec(sql)
    properties = properties_hashes.map { |property_hash| Property.new(property_hash) }
    db.close()
    return properties
  end

  def Property.delete_all
    db = PG.connect({dbname: "properties", host: "localhost"})
    sql = "DELETE FROM properties;"
    db.prepare("delete_all", sql)
    db.exec_prepared("delete_all")
    db.close()
  end

end
