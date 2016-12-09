require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/stylist")
require('./lib/client')
require("pg")

DB = PG.connect({:dbname => "hair_salon_test"})

get("/") do
  erb(:index)
end

get("/stylists/new") do
  erb(:stylist_form)
end

get('/stylists') do
  @stylists = Stylist.all()
  erb(:stylists)
end

get("/stylists/:id") do
  @stylist = Stylist.find(params.fetch("id").to_i())
  erb(:stylist)
end

post("/stylists") do
  name = params.fetch("name")
  stylist = Stylist.new({:name => name, :id => nil})
  stylist.save()
  @stylists = Stylist.all()
  erb(:stylist_success)
 end

 post("/clients") do
   name = params.fetch("name")
   stylist_id = params.fetch("stylist_id").to_i()
   @stylist = Stylist.find(stylist_id)
   @client = Client.new({:name => name, :stylist_id => stylist_id, :id => nil})
   @client.save()
   @clients = Client.all()
   erb(:client_success)
 end

 get ("/clients") do
   @clients = Client.all()
   erb(:clients)
 end

 get("/clients/:id") do
   @client = Client.find(params.fetch("id").to_i())
   @stylists = Stylist.all()
   erb(:client)
 end

 get("/stylists/:id/edit") do
  @stylist = Stylist.find(params.fetch("id").to_i())
  erb(:stylist_edit)
end

get("/clients/:id/edit") do
 @client = Client.find(params.fetch("id").to_i())
 erb(:client_edit)
end

patch("/stylists/:id") do
  name = params.fetch("name")
  @stylist = Stylist.find(params.fetch("id").to_i())
  @stylist.update({name: name})
  erb(:stylist)
end

patch("/clients/:id") do
  name = params.fetch("name")
  @client = Client.find(params.fetch("id").to_i())
  @client.update({name: name})
  erb(:client)
end

delete("/stylists/:id") do
  @stylist = Stylist.find(params.fetch("id").to_i())
  @stylist.delete()
  @stylist = Stylist.all()
  erb(:index)
end

delete("/clients/:id") do
    @client = Client.find(params.fetch("id").to_i())
    @client.delete()
    @client = Client.all()
    erb(:index)
end
