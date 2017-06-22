class ArticlePage < SitePrism::Page
  set_url "/apis/radio/collections/articles/documents/new"

  element :titleText, "div#ql-editor-1"
  element :editMetaField, "a#data-route-trigger-6"
  element :save_button, "div.dadiCells-info button[class$='js-editor-save']"

  element :publicationPlaceholder, "input[placeholder='Select publication...']"
  element :taxonomyText, "div.cf > label"
  elements :categoryHolder, "div.optgroup-header"
  element :selectedResults, "label.marg"
  elements :backToMainContent, "div.modal__footer button[onclick*='close()']"
  element :successmessage, "div.feedback.feedback--toaster.success.show"
  element :hello1, "div#dadi-route-6 div[class^='js-dadiCells__cell pad']:nth-child(3) select[placeholder='Select category...']"
  element :hello2, "select[placeholder='Select publication...']"



  def createArticle(heading)
    titleText.set heading
    editMetaField.click
    sleep 1
    Helpers.wait_until(publicationPlaceholder, 5)
    publicationPlaceholder.set "Clyde 1"
    publicationPlaceholder.native.send_keys(:return)
    sleep 6
   puts "The number of category holder is #{categoryHolder.count}"
    categoryHolder.each do |category|

      puts "the category is #{category.text}"
      if category.text == "Comedy"
        sleep 2
         category.native.send_keys(:return)
         # category.click
        break
      end
    end
    # page.select 'Comedy', :from => "div[class*='categoryMaster single'] div.option"
    # sleep 10
    backToMainContent.each do |button|
      puts "the button text is #{button.text}"
      if button.text == "Back to main content"
        puts "Clicking button now "
        button.click
        break
        # button.native.send_keys(:return)
      end
    end
    sleep 2
    save_button.click
    sleep 5
    Helpers.wait_until(successmessage, 30)
  end

  def testyou
    titleText.set "Hello"
    editMetaField.click
    sleep 1
    # Helpers.wait_until(publicationPlaceholder, 5)
    sleep 5
    puts "the publication drop down is visible or not --> #{hello2.visible?}"
    hello2.select("Clyde 3")
    sleep 10
  end

end