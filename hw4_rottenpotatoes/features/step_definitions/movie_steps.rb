# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create(movie)
  end
end

Then /^the director of "([^"]*)" should be "([^"]*)"$/ do |m, dir|
  page.should have_xpath('.//li', :text => /^Director:\s*#{dir}/)
  step %Q{I should see "#{m}"}
  step %Q{I should see "#{dir}"}
end

And /^I add the movie:(.*)$/ do |movie_details|
  details = movie_details.to_s.gsub(/\s/, "").split(",")
  t = details[0]
  rat = details[1]
  date = details[2].split("-")
  step %Q{I fill in "movie_title" with "#{t}"}
  step %Q{I select "#{rat}" from "movie_rating"}
  step %Q{I select "#{date[2]}" from "movie_release_date_1i"}
  step %Q{I select "#{date[1]}" from "movie_release_date_2i"}
  step %Q{I select "#{date[0]}" from "movie_release_date_3i"}
  step %Q{I press "Save Changes"}
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  if page.respond_to? :should
    page.body.index(e1).should < page.body.index(e2)
  else
    assert page.body.index(e1) < page.body.index(e2)
  end
end

# Given a certain order, make sure that elements appear in that order on the
# page
Then /I should see the following in this order:/ do |movies_table|
  movie = nil
  movies_table.raw.flatten.each do |m|
    if movie == nil
        movie = m
    else
      step %Q{I should see "#{movie}" before "#{m}"}
      movie = m
    end
  end
end


# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb

  # This snippet will (un)check all the ratings in rating_list
  rating_list.to_s.gsub(/\s/, "").split(",").each do |r|
    step %Q{I #{uncheck.to_s}check "ratings_#{r}"}
  end
end

Then /^I should see movies with the ratings: (.*)/ do |rating_list|
  # We have captured the ratings that we want displayed
  rating_list.to_s.gsub(/\s/, "").split(",").each do |rating|
    #step %Q{I should see /^#{rating}$/ within the movies table}
    # We need to search for "rating" only within the movies table
    if page.respond_to? :should
      page.should have_xpath('//table[@id=\'movies\']', :text => /^#{rating}$/)
    else
      assert page.has_xpath?('//table[@id=\'movies\']', :text => /^#{rating}$/)
    end
  end
end

Then /^I should not see movies with the ratings: (.*)$/ do |rating_list|
  # We have captured the ratings that we want displayed
  rating_list.to_s.gsub(/\s/, "").split(",").each do |r|
    if page.respond_to? :should
      page.should have_no_xpath('//table[@id=\'movies\']', :text => /^#{r}$/)
    else
      assert page.has_no_xpath?('//table[@id=\'movies\']', :text => /^#{r}$/)
    end
  end
  #step %Q{I should not see /PG-13/ within the movies table}
  #rating_list.to_s.gsub(/\s/, "").split(",").each do |rating|
    #step %Q{I should not see /^#{rating}$/ within the movies table}
  #end
end

Then /^I should see all of the movies/ do
  movie_count = Movie.all.count
  row_count = page.all('tbody/tr').count
  row_count.should == movie_count
end

And /^the following checkboxes should (not )?be checked: (.*)$/ do |un, rating_list|
  # We have captured the ratings that we want displayed
  rating_list.to_s.gsub(/\s/, "").split(",").each do |r|
    step %Q{the "ratings_#{r}" checkbox should #{un}be checked}
  end
end
