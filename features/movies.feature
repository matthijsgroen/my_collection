Feature: Manage movies
  In order to manage a collection of movies
  the user
  wants to add movies, edit movies and delete movies
  
  Background:
    Given the user is identified as guidopater@plan8.nl

  Scenario: User adds a movie to his/her collection
    Given I am on the new add page
    When I fill in "Movies" with "movies 1"
    And I fill in "To" with "to 1"
    And I fill in "Collection" with "collection 1"
    And I press "Create"
    Then I should see "movies 1"
    And I should see "to 1"
    And I should see "collection 1"

  # Rails generates Delete links that use Javascript to pop up a confirmation
  # dialog and then do a HTTP POST request (emulated DELETE request).
  #
  # Capybara must use Culerity/Celerity or Selenium2 (webdriver) when pages rely
  # on Javascript events. Only Culerity/Celerity supports clicking on confirmation
  # dialogs.
  #
  # Since Culerity/Celerity and Selenium2 has some overhead, Cucumber-Rails will
  # detect the presence of Javascript behind Delete links and issue a DELETE request 
  # instead of a GET request.
  #
  # You can turn this emulation off by tagging your scenario with @no-js-emulation.
  # Turning on browser testing with @selenium, @culerity, @celerity or @javascript
  # will also turn off the emulation. (See the Capybara documentation for 
  # details about those tags). If any of the browser tags are present, Cucumber-Rails
  # will also turn off transactions and clean the database with DatabaseCleaner 
  # after the scenario has finished. This is to prevent data from leaking into 
  # the next scenario.
  #
  # Another way to avoid Cucumber-Rails' javascript emulation without using any
  # of the tags above is to modify your views to use <button> instead. You can
  # see how in http://github.com/jnicklas/capybara/issues#issue/12
  #
  Scenario: Delete add
    Given the following adds:
      |movies|to|collection|
      |movies 1|to 1|collection 1|
      |movies 2|to 2|collection 2|
      |movies 3|to 3|collection 3|
      |movies 4|to 4|collection 4|
    When I delete the 3rd add
    Then I should see the following adds:
      |Movies|To|Collection|
      |movies 1|to 1|collection 1|
      |movies 2|to 2|collection 2|
      |movies 4|to 4|collection 4|
