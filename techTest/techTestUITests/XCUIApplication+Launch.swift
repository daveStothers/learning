//
//  techTestUITests.swift
//  techTestUITests
//
//  Created by David Stothers on 25/05/2019.
//  Copyright © 2019 Stotherd. All rights reserved.
//

import XCTest

extension XCUIApplication {
    var isDisplayingCorrectMainView: Bool {
        return otherElements["mainView"].exists
    }
    
    var isDisplayingIssuesView: Bool {
        return otherElements["issuesListView"].exists
    }
    
    var isDisplayingUpdateIssueView: Bool {
        return otherElements["updateIssueView"].exists
    }
    
    var isDisplayingPersonsView: Bool {
        return otherElements["peopleListView"].exists
    }
}



