class CollectionPage < SitePrism::Page
  set_url "/apis/radio/collections#"

  element  :searchInput, "input.w-1-1.dadi-card-search"
  elements :searchDisplays, "div[class*='dadi-tab-db--radio']"
  elements :searchResults, "div.col.w-1-3.txt--grey input"

  def search(keyword)
    Helpers.enter_text(searchInput, keyword)
    waitUntilSearchResultsDisplay
  end

  def verifySearchResults(expectedResults)
    searchResults.each do |results|
      return true if results[:value].split("/").last == expectedResults
    end
  end

  private

  def waitUntilSearchResultsDisplay
    searchDisplays.each do |result|
      break if result.visible?
    end
  end



end