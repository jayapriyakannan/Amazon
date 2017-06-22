
##Given Steps

##When Steps

When(/^I attempt to login with invalid credentials$/) do
  @cms = CMS.new
  @cms.login.loginWithInvalidCredentials
end

When(/^I have logged in as (defaultUser|Manager|Admin)$/) do |userType|
  @cms = CMS.new
  case userType
    when "defaultUser"
      @cms.login.loginAsDefaultUser
    when "manager"
      @cms.login.loginAsManager
    when "admin"
      @cms.login.loginAsAdmin
    else
      @cms.login.loginAsDefaultUser
  end
end



##Then Steps
Then(/^I am shown an error "([^"]*)" message$/) do |expectedErrorMsg|
  expect(@cms.login.loginErrorMsg).to include expectedErrorMsg
end

Then(/^I am in home page$/) do
  expect(@cms.home.homePageDisplayed?).to be true
end

When(/^I click Sign\-in$/) do
  page.find(:xpath, './/*[@id='nav-link-yourAccount']/span[2]').click
end