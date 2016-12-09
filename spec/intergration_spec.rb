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

describe('get names for a single stylist', {:type => :feature}) do
  it('allows a user to click a list to see the tasks and details for it') do
    test_list = List.new({:name => "Coding work", :id => nil})
    test_list.save()
    test_task = Task.new({:description => "learn SQL", :list_id => test_list.id()})
    test_task.save()
    visit('/lists')
    click_link(test_list.name())
    expect(page).to have_content(test_task.description())
  end
end
