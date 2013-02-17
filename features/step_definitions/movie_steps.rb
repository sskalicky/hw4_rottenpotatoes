# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create!(movie)
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  regexp = /#{e1}.*#{e2}/m
  page.body.should =~ regexp
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split(',').each do |rating|
    step "I #{uncheck}check \"ratings_#{rating.strip}\""
  end

end

Then /I should (not )?see the following movies: (.*)/ do |invisible, movies_list|
  movies_list.split(',').each do |movie|
    step "I should #{invisible}see \"#{movie.strip}\""
  end
end

Then /I should see (all of the|no) movies/ do |count|
  if count == "no"
    page.all('table#movies tbody tr').count.should == 0
  else
	page.all('table#movies tbody tr').count.should == Movie.count
  end	
end

Then /the director of "(.*)" should be "(.*)"/ do |title, director|
  director.should == Movie.find_by_title(title).director
end
