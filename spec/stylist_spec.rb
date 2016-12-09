require('spec_helper')

describe(Stylist) do
  describe(".all") do
    it("start off with no lists") do
      expect(Stylist.all()).to(eq([]))
    end
  end
end

describe("#name") do
    it("tells you its stylis name") do
      stylist = Stylist.new({:name => "Best Stylist", :id => nil})
      expect(stylist.name()).to(eq("Best Stylist"))
    end
  end

  describe("#id") do
    it("sets its ID when you save it") do
      stylist = Stylist.new({:name => "shawn john", :id => nil})
      stylist.save()
      expect(stylist.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe("#save") do
  it("lets you save stylists to the database") do
    stylist = Stylist.new({:name => "shawn john", :id => nil})
    stylist.save()
    expect(Stylist.all()).to(eq([stylist]))
  end
end

describe("#==") do
  it("is the same list if it has the same name") do
    stylist1 = Stylist.new({:name => "Shawn John", :id => nil})
    stylist2 = Stylist.new({:name => "Shawn John", :id => nil})
    expect(stylist1).to(eq(stylist2))
  end
end

describe(".find") do
  it("returns a stylist by its ID") do
    test_stylist = Stylist.new({:name => "Shawn John", :id => nil})
    test_stylist.save()
    test_stylist2 = Stylist.new({:name => "Shawn John", :id => nil})
    test_stylist2.save()
    expect(Stylist.find(test_stylist2.id())).to(eq(test_stylist2))
  end
end
