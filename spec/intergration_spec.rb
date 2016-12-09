require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('adding a new stylist', {:type => :feature}) do
  it('allows a user to click a stylist to see the clients name') do
    visit('/')
    click_link('Add New Stylist')
    fill_in('name', :with =>'anderson cooper')
    click_button('Add Stylist')
    expect(page).to have_content('Success!')
  end
end

describe('viewing all of the stylists', {:type => :feature}) do
  it('allows a user to see all of the stylists that have been created') do
    stylist = Stylist.new({:name => "lisa ling", :id => nil})
    stylist.save()
    visit('/')
    click_link('View All Stylists')
    expect(page).to have_content(stylist.name)
  end
end

describe('adding clients to a stylist', {:type => :feature}) do
  it('allows a user to add a client to a stylist') do
    test_stylist = Stylist.new({:name => "case you", :id => nil})
    test_stylist.save()
    visit("/stylists/#{test_stylist.id()}")
    fill_in("name", {:with => "handsom man"})
    click_button("Add a client")
    expect(page).to have_content("Success")
  end
end
