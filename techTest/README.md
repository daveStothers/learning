## TechTest by David Stothers

# Approach

Broke the test into tasks and subtasks, based on the requirements:

- Create database on my personal web server
- Create the php based apis for the data (copied down to here in techTest-phpfiles)
	- get a list of bugs
	- get a list of users
	- create bug
	- create person
	- change a bug
	- change a person
	- close bug
	- reopen bug
- Test the apis with postman
- Create a UI for the main menu
	- Use a generic single view template
- Create a UI for listing issues
- Write the back end for the issues listing
	- Create a class to request the data
	- Create a class to parse the issues data
	- Write some test cases for the parsing
- Create a UI for listing issues
- Write the back end for the people listing
	- Create a class to request the data
	- Create a class to parse the people data
- Create a UI for creating/modifying issues
- Write the back end for creating/modifying issues
- Create a UI for creating/modifying users
- Write the back end for creating/modifying users
- Write and create remaining tests and UI tests.
- Write any documentation

As there was significant repetition, and to stay within some sensible time limits, I have not completed:

- Create a UI for creating/modifying users
- Write the back end for creating/modifying users

As these should be extremely similar to the same logic for issues, and as instructed I wanted to keep within a timeframe

And:

- networking tests, alongside tests on the apis

As I have not tested these areas before, and I felt it would use a significant amount of the timeframe

# Use of the app

Coded and executable under Xcode 10.1.
UI was written to display correctly on an iPhone 8 and XR. May not display correctly on larger/smaller devices.

To view a list of issues:
- Click `Get list of issues`
- You may need to wait for the issues to load
- Select your issue from the scrollable list, and view the detail below
- To close/reopen the ticket click the `Close ticket`/`reopen ticket`button.
- You can filter the issues with the button at the top `All tickets` to show only open or closed tickets.

To modify the ticket otherwise, including assigning a user to it,
- Click update ticket
- You can then modify any of the fields that appear, and click submit ticket to update it.
- when modifying assignees they autocomplete from the registered usernames

To create an issue:
- Go back to the main menu
- Click `Get list of issues`
- You may need to wait for the issues to load
- Click `Create ticket`
- Fill in the details and click `Submit ticket`

To view people:
- Click `Get list of people`
- You may need to wait for the people to load
- Select your issue from the scrollable list, and view the detail below

The expected behaviour for adding and updating people would've been extremely similar to the behaviour for issues

To run unit and UI tests, use the standard xcode testing infrastructure (command-u or Product-> Test)
Note that I haven't written mocks for the api requests so the UI tests rely on live data, specifically the first entry that appears on the list of issues.

# Notes

Timestamps do not get reset when an issue is reopened.

I would've preferred to use Appium for the UI tests as it tests as a black box and can be based on ruby.

I would prefer a better way of showing the list of issues, that clearly shows there is more to the table.

I would normally use gitflow with appropriate PR reviews but as I'm the only developer for this repository, I have been pushing direct to master
