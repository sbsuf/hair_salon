class Client
  attr_reader(:id, :name, :stylist_id)

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @stylist_id = attributes.fetch(:stylist_id)
    @id = attributes.fetch(:id)
  end

  def self.all()
    returned_clients = DB.exec("SELECT * FROM clients;")
    clients = []
    returned_clients.each do |client|
      name = client.fetch("name")
      stylist_id = client.fetch("stylist_id").to_i()
      id = client.fetch('id').to_i()
      clients.push(Client.new({name: name, stylist_id: stylist_id, id: id}))
    end
    clients
  end

  def save()
     result = DB.exec("INSERT INTO clients (name, stylist_id) VALUES ('#{@name}', '#{@stylist_id}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  def self.find(id)
    found_client = nil
    Client.all().each() do |client|
      if client.id().== (id)
        found_client = client
      end
    end
    found_client
  end

  def update(attributes)
    @name = attributes.fetch(:name)
    DB.exec("UPDATE clients SET name = '#{@name}' WHERE id = #{@id};")
  end

  def delete()
    DB.exec("DELETE FROM clients WHERE id = #{self.id()};")
  end

  def ==(another_client)
    self.name == another_client.name && self.stylist_id == another_client.stylist_id
  end

end
