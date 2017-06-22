class DocumentsPage < SitePrism::Page
  set_url "/apis/radio/collections/articles/documents"

  element :advanced_search, "li button[class$=' dadiFilterToggle']"
  element :minus_symbol, "div.dadiFilter__controls span[class*='fa-minus-circle']"
  element :plus_symbol, "div.dadiFilter__controls span[class*='fa-plus-circle']"
  element :input_field, "input.dadiFilter__value"
  elements :results, "table[class$='responsive'] tbody td.String a"
  element :overlay, "body.default-theme.loading-overlay"

  def advancedSearch(keyword)
    clickAdvancedSearch
    Helpers.enter_text(input_field, keyword)
    Helpers.enter_key_board(input_field)
    Helpers.wait_until(overlay, 10)
  end

  def verifySearchResults(expectedString)
    wait_until_overlay_invisible(30)
    raise "Search results has NOT found " if results.count == 0
    results.each do |row|
      return true if row.text.match(expectedString)
    end
  end

  private
  def clickAdvancedSearch
    Helpers.wait_until(advanced_search, 10)
    advanced_search.click
    Helpers.wait_until(minus_symbol, 20)
  end
end