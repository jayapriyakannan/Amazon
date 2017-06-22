
##Given Steps

##When Steps
When(/^I search for "([^"]*)" in document page$/) do |searchString|
  @documentSearchString = searchString
  @cms.documents.load
  @cms.documents.advancedSearch(@documentSearchString)
end


##Then Steps
Then(/^I am shown the filtered results$/) do
  expect(@cms.documents.verifySearchResults(@documentSearchString)).to be true
end
