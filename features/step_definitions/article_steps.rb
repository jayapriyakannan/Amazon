
##Given Steps

##When Steps

When(/^I create a new article$/) do
  @article_heading = Helpers.random_string(5)
  @cms.article.load
  # @cms.article.createArticle(@article_heading)
  sleep 1
  @cms.article.testyou
  sleep 10
end

When(/^I delete the created article$/) do

end

##Then Steps
Then(/^article should be created successfully$/) do
  puts "Verify that image has added successfully"
end

Then(/^article should be deleted successfully$/) do

end