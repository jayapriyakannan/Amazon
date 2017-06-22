class LoginPage < SitePrism::Page
  set_url "/sign-in"

  element :username, "#username"
  element :password, "#password"
  element :signButton, "div.modal__footer button[class$='btn--positive']"
  element :settings, "li a[href='/users']"
  element :errorMsg, "div.fwb"

  def load
    Capybara.app_host = PLR_ENV
    raise "Customer_app URL NOT defined for : #{PLR_ENV} Environment" if Capybara.app_host.nil?
    $logger.info "Navigating to : #{Capybara.app_host}"
    visit Capybara.app_host
    Helpers.wait_until(signButton, 10)
  end

  def loginAsDefaultUser
    load
    enterUserCredentials(Helpers.getUserLoginId("defaultUser"), Helpers.getUserPassword("defaultUser"))
    signButton.click
    Helpers.wait_until(settings, 30)
  end

  def loginWithInvalidCredentials
    load
    enterUserCredentials("hello@test.co.uk", "BlahBalah")
    signButton.click
    Helpers.wait_until(errorMsg, 30)
  end

  def loginErrorMsg
    Helpers.wait_until(errorMsg, 10)
    errorMsg.text
  end

  private

  def enterUserCredentials(userId, passwordInput)
    Helpers.enter_text(username, userId)
    Helpers.enter_text(password, passwordInput)
  end

end