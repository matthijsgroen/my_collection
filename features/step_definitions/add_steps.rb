Given /^the following adds:$/ do |adds|
  Add.create!(adds.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) add$/ do |pos|
  visit adds_path
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following adds:$/ do |expected_adds_table|
  expected_adds_table.diff!(tableish('table tr', 'td,th'))
end
