class Helpers
  extend RSpec::Matchers
  include SitePrism::ElementChecker
  include SitePrism::Page
  require "rubygems"

  def self.select_value(webelement, search_text)
    enter_text(webelement, search_text)
    webelement.native.send_keys(:return)
  end

  def self.enter_text(web_element, enter_text)
    wait_until(web_element, 30)
    web_element.set enter_text
    web_element.value.should match enter_text
  end

  def self.click_wait(web_element, wait_element)
    web_element.click
    wait_until(wait_element, 30)
  end

  def self.enter_key_board(webElement)
    webElement.native.send_keys(:return)
  end

  def self.wait_until(wait_element, timeout)
    Timeout.timeout timeout, SitePrism::TimeOutWaitingForElementVisibility do
      Capybara.using_wait_time 0 do
        sleep 0.05 until wait_element.visible?
      end
    end
  end

  def self.drag_and_drop(page, source, target)
    page.execute_script("function createEvent(typeOfEvent) {\n" +
                            "var event =document.createEvent(\"CustomEvent\");\n" +
                            "event.initCustomEvent(typeOfEvent,true, true, null);\n" +
                            "event.dataTransfer = {\n" +"data: {},\n" +"setData: function (key, value) {\n" +"this.data[key] = value;\n" +"},\n" +
                            "getData: function (key) {\n" +"return this.data[key];\n" +"}\n" +"};\n" +"return event;\n" +"}\n" +"\n" +
                            "function dispatchEvent(element, event,transferData) {\n" +"if (transferData !== undefined) {\n" +
                            "event.dataTransfer = transferData;\n" +"}\n" +"if (element.dispatchEvent) {\n" +
                            "element.dispatchEvent(event);\n" +"} else if (element.fireEvent) {\n" +"element.fireEvent(\"on\" + event.type, event);\n" +"}\n" +"}\n" +
                            "\n" +"function simulateHTML5DragAndDrop(element, destination) {\n" +"var dragStartEvent =createEvent('dragstart');\n" +
                            "dispatchEvent(element, dragStartEvent);\n" +"var dropEvent = createEvent('drop');\n" +"dispatchEvent(destination, dropEvent,dragStartEvent.dataTransfer);\n" +
                            "var dragEndEvent = createEvent('dragend');\n" +"dispatchEvent(element, dragEndEvent,dropEvent.dataTransfer);\n" +"}\n" +"\n" +"var source = arguments[0];\n" +
                            "var destination = arguments[1];\n" +"simulateHTML5DragAndDrop(source,destination);",
                        source, target)
  rescue Exception => e
    puts "ERROR :" + e.to_s
  end

  def self.random_string(length = 10)
    chars = "ABCDEFGHJKLMNPQRSTUVWXYZABCDEFGHJKLMNPQRSTUVWXYZ"
    result = ""
    length.times { result << chars[rand(chars.size)] }
    result
  end

  def self.getUserLoginId(userType)
    $userConfig[userType.to_sym][:loginId]
  end

  def self.getUserPassword(userType)
    $userConfig[userType.to_sym][:password]
  end
end
