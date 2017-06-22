##Given steps


##When steps
When(/^I search for "([^"]*)" collection$/) do |searchKeyword|
  @cms.collection.load
  @collectionSearch = searchKeyword
  @cms.collection.search(@collectionSearch)

end


##Then steps
Then(/^I am shown the results for collection$/) do
  expect(@cms.collection.verifySearchResults(@collectionSearch)).to be true
end