require("rspec")
require("pg")
require("stylist")

DB = PG.connect({:dbname => 'hair_salon_test'})
