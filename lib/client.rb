class Client
  attr_reader(:name, :stylist_id)

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @stylist_id = attributes.fetch(:stylist_id)
  end

  def self.all()
    returned_clients = DB.exec("SELECT * FROM clients;")
    clients = []
    returned_clients.each do |client|
      name = client.fetch("name")
      stylist_id = client.fetch("stylist_id").to_i()
      clients.push(Client.new({name: name, stylist_id: stylist_id}))
    end
    clients
  end

  def save()
    DB.exec("INSERT INTO clients (name, stylist_id) VALUES ('#{@name}', #{@stylist_id});")
  end

  def ==(another_client)
    self.name == another_client.name && self.stylist_id == another_client.stylist_id
  end

end
