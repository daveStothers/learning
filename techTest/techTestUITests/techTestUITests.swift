//
//  techTestUITests.swift
//  techTestUITests
//
//  Created by David Stothers on 25/05/2019.
//  Copyright © 2019 Stotherd. All rights reserved.
//

import XCTest

class techTestUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        
        // We send a command line argument to our app, to enable it to reset its state
        app.launchArguments.append("--uitesting")

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
    }

    func testLaunchDisplaysCorrectly() {
        //This test ensures its loaded correctly
        app.launch()
        XCTAssertTrue(app.isDisplayingCorrectMainView)
        app.buttons["Get list of issues"].tap()
        
        
    }
    
    func testIssuesScreenDisplaysCorrectly() {
        //Currently Uses REAL data, so will fail as soon as these are updated, and requires the sleeps to wait for the data to be populated. Requires networking mocks with fake but realistic data to generate predictable and therefore testable data
        app.launch()
        let getListOfIssuesButton = app/*@START_MENU_TOKEN@*/.buttons["Get list of issues"]/*[[".otherElements[\"mainView\"].buttons[\"Get list of issues\"]",".buttons[\"Get list of issues\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        getListOfIssuesButton.tap()
        XCTAssertTrue(app.isDisplayingIssuesView)
        let test1234StaticText = app/*@START_MENU_TOKEN@*/.tables.staticTexts["Test1234"]/*[[".otherElements[\"issuesListView\"].tables",".cells.staticTexts[\"Test1234\"]",".staticTexts[\"Test1234\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/
        test1234StaticText.tap()
        app/*@START_MENU_TOKEN@*/.buttons["Reopen Ticket"]/*[[".otherElements[\"issuesListView\"].buttons[\"Reopen Ticket\"]",".buttons[\"Reopen Ticket\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        test1234StaticText.tap()
        app/*@START_MENU_TOKEN@*/.buttons["Close Ticket"]/*[[".otherElements[\"issuesListView\"].buttons[\"Close Ticket\"]",".buttons[\"Close Ticket\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["Update button broken"]/*[[".otherElements[\"issuesListView\"].tables",".cells.staticTexts[\"Update button broken\"]",".staticTexts[\"Update button broken\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["Update Ticket"]/*[[".otherElements[\"issuesListView\"].buttons[\"Update Ticket\"]",".buttons[\"Update Ticket\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    XCTAssertTrue(app.isDisplayingUpdateIssueView)
        let updateissueviewElement = app.otherElements["updateIssueView"]
        updateissueviewElement.children(matching: .textField).element(boundBy: 0).tap()
        let textField = updateissueviewElement.children(matching: .textField).element(boundBy: 1)
        textField.tap()
        let textView = updateissueviewElement.children(matching: .textView).element
        textView.tap()
        app/*@START_MENU_TOKEN@*/.buttons["Update Ticket"]/*[[".otherElements[\"updateTicketView\"].buttons[\"Update Ticket\"]",".buttons[\"Update Ticket\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let backToMenuButton = app/*@START_MENU_TOKEN@*/.buttons["Back to menu"]/*[[".otherElements[\"updateTicketView\"].buttons[\"Back to menu\"]",".buttons[\"Back to menu\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        backToMenuButton.tap()
        app/*@START_MENU_TOKEN@*/.buttons["Create Ticket"]/*[[".otherElements[\"issuesListView\"].buttons[\"Create Ticket\"]",".buttons[\"Create Ticket\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCTAssertTrue(app.isDisplayingUpdateIssueView)
        backToMenuButton.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["Test1234"]/*[[".otherElements[\"issuesListView\"].tables",".cells.staticTexts[\"Test1234\"]",".staticTexts[\"Test1234\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["Update Ticket"]/*[[".otherElements[\"issuesListView\"].buttons[\"Update Ticket\"]",".buttons[\"Update Ticket\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCTAssertTrue(app.isDisplayingUpdateIssueView)
        app/*@START_MENU_TOKEN@*/.buttons["Back to menu"]/*[[".otherElements[\"updateTicketView\"].buttons[\"Back to menu\"]",".buttons[\"Back to menu\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCTAssertTrue(app.isDisplayingIssuesView)
        app/*@START_MENU_TOKEN@*/.buttons["Back to menu"]/*[[".otherElements[\"issuesListView\"].buttons[\"Back to menu\"]",".buttons[\"Back to menu\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
         XCTAssertTrue(app.isDisplayingCorrectMainView)
        getListOfIssuesButton.tap()
        XCTAssertTrue(app.isDisplayingIssuesView)
        app/*@START_MENU_TOKEN@*/.buttons["All tickets"]/*[[".otherElements[\"issuesListView\"].buttons[\"All tickets\"]",".buttons[\"All tickets\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["Open tickets"]/*[[".otherElements[\"issuesListView\"].buttons[\"Open tickets\"]",".buttons[\"Open tickets\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["Closed tickets"]/*[[".otherElements[\"issuesListView\"].buttons[\"Closed tickets\"]",".buttons[\"Closed tickets\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCTAssertTrue(app.isDisplayingIssuesView)
    }
    
    func testPeopleScreenDisplaysCorrectly() {
        //Currently Uses REAL data, so will fail as soon as these are updated, and requires the sleeps to wait for the data to be populated. Requires networking mocks with fake but realistic data to generate predictable and therefore testable data
        app.launch()
        
        app/*@START_MENU_TOKEN@*/.buttons["Get list of people"]/*[[".otherElements[\"mainView\"].buttons[\"Get list of people\"]",".buttons[\"Get list of people\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.tables.staticTexts["stotherd"]/*[[".otherElements[\"peopleListView\"].tables",".cells.staticTexts[\"stotherd\"]",".staticTexts[\"stotherd\"]",".tables"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        let fullNameDaveStothersStaticText = app/*@START_MENU_TOKEN@*/.staticTexts["Full name: \nDave Stothers"]/*[[".otherElements[\"peopleListView\"].staticTexts[\"Full name: \\nDave Stothers\"]",".staticTexts[\"Full name: \\nDave Stothers\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        fullNameDaveStothersStaticText.tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["Person 1: stotherd"]/*[[".otherElements[\"peopleListView\"].staticTexts[\"Person 1: stotherd\"]",".staticTexts[\"Person 1: stotherd\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["Back to menu"]/*[[".otherElements[\"peopleListView\"].buttons[\"Back to menu\"]",".buttons[\"Back to menu\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
    }

}
