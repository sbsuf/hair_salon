require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/stylist")
require('./lib/client')
require("pg")

DB = PG.connect({:dbname => "hair_salon"})

get("/") do
  erb(:index)
end

get("/stylists/new") do
  erb(:index)
end

post("/stylists") do
  name = params.fetch("name")
  stylist = Stylist.new({:name => name, :id => nil})
  stylist.save()
  erb(:stylist_success)
 end

 post("/clients") do
   name = params.fetch("name")
   stylist_id = params.fetch("stylist_id").to_i()
   @stylist = Stylist.find(stylist_id)
   @client = Client.new({:name => description, :stylist_id => list_id})
   @client.save()
   erb(:client_success)
 end
