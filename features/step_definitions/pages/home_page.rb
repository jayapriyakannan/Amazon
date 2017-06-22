class HomePage < SitePrism::Page
  set_url "/apis"

  element :settings, "li a[href='/users']"
  element :sideBar, "div.sidebar__content.stick"


  def homePageDisplayed?
    Helpers.wait_until(sideBar, 20)
    return true if sideBar.visible?
  end

end