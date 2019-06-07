//
//  techTestTests.swift
//  techTestTests
//
//  Created by David Stothers on 25/05/2019.
//  Tests all JSON parsing and data handling methods. Networking tests have not been included although I did make a start on them for the sake of getting the project finished.
//

import XCTest
@testable import techTest

class techTestTests: XCTestCase {

    

    func testIssuesParserProcessesNormalJSONCorrectly() {
        let testJson: Data? = """
        {
            "bugs": [
                {
                    "id": 1,
                    "title": "Test1234",
                    "fullDescription": "It’s a bug!",
                    "open": 0,
                    "assignee": 1,
                    "timestamp": "2019-06-03 18:08:10"
                },
                {
                    "id": 5,
                    "title": "Update button broken",
                    "fullDescription": "The update button doesn’t work right",
                    "open": 1,
                    "assignee": 1,
                    "timestamp": "2019-06-03 19:03:30"
                }
            ]
        }
        """.data(using: .utf8)
        var issues = [IssuesParser.Bug]()
        do {
            issues = try IssuesParser().parseJson(data: testJson!)!
        }
        catch {
            XCTFail()
        }
      
        XCTAssertEqual(issues.count, 2)
    }
    
    func testIssuesParserThrowsOnMalformedJSON() {
        // test misnamed parameter
        let testJson: Data? = """
         {
            "bugs": [
                {
                    "id": 1,
                    "NotCorrect": "Test1234",
                    "fullDescription": "It’s a bug!",
                    "open": 0,
                    "assignee": 1,
                    "timestamp": "2019-06-03 18:08:10"
                }
            ]
        }
        """.data(using: .utf8)
        var issues = [IssuesParser.Bug]()
        do {
            issues = try IssuesParser().parseJson(data: testJson!)!
        }
        catch {
            XCTAssertTrue(issues.isEmpty)
        }
        XCTAssertTrue(issues.isEmpty)
        
        //Test missing title
        let testJson2: Data? = """
         {
            "bugs": [
                {
                    "id": 1,
                    "fullDescription": "It’s a bug!",
                    "open": 0,
                    "assignee": 1,
                    "timestamp": "2019-06-03 18:08:10"
                }
            ]
        }
        """.data(using: .utf8)
        var issues2 = [IssuesParser.Bug]()
        do {
            issues2 = try IssuesParser().parseJson(data: testJson2!)!
        }
        catch {
            XCTAssertTrue(issues2.isEmpty)
        }
        XCTAssertTrue(issues2.isEmpty)
        
        //Test wrong type for title
        let testJson3: Data? = """
        {
            "bugs": [
                {
                    "id": 1,
                    "title": 1234,
                    "fullDescription": "It’s a bug!",
                    "open": 0,
                    "assignee": 1,
                    "timestamp": "2019-06-03 18:08:10"
                }
            ]
        }
        """.data(using: .utf8)
        var authorities3 = [IssuesParser.Bug]()
        do {
            authorities3 = try IssuesParser().parseJson(data: testJson3!)!
        }
        catch {
            XCTAssertTrue(authorities3.isEmpty)
        }
    }
    
    func testAuthoritiesParserThrowsOnEmptyJSON() {
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let testJson: Data? = """
        {
           
        }
        """.data(using: .utf8)
        var issues = [IssuesParser.Bug]()
        do {
            issues = try IssuesParser().parseJson(data: testJson!)!
        }
        catch {
            XCTAssertTrue(issues.isEmpty)
        }
        XCTAssertTrue(issues.isEmpty)
    }

    func testPerformanceAuthorities() {
        // Testing timeing of parsing
        self.measure {
            let testJson: Data? = """
            {
                "bugs": [
                    {
                        "id": 1,
                        "title": "Test1234",
                        "fullDescription": "It’s a bug!",
                        "open": 0,
                        "assignee": 1,
                        "timestamp": "2019-06-03 18:08:10"
                    },
                    {
                        "id": 5,
                        "title": "Update button broken",
                        "fullDescription": "The update button doesn’t work right",
                        "open": 1,
                        "assignee": 1,
                        "timestamp": "2019-06-03 19:03:30"
                    }
                ]
            }
            """.data(using: .utf8)
            do {
                _ = try IssuesParser().parseJson(data: testJson!)!
            }
            catch {
                XCTFail()
            }
            
            
        }
    }
    
    func testPeopleParserProcessesNormalJSONCorrectly() {
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let testJson: Data? = """
        {
            "people": [
                {
                    "id": 1,
                    "firstName": "Dave",
                    "lastName": "Stothers",
                    "username": "stotherd"
                },
                {
                    "id": 2,
                    "firstName": "Arthur",
                    "lastName": "Dent",
                    "username": "iForgotMyTowel"
                }
            ]
        }
        """.data(using: .utf8)
        var people = [PeopleParser.Person]()
        do {
            people = try PeopleParser().parseJson(data: testJson!)!
        }
        catch {
            XCTFail()
        }
        
        XCTAssertEqual(people.count, 2)
        
    }
    
    func testEstablishmentParserThrowsOnMalformedJSON() {
        // test misnamed username (actually used an api with this very mistake once!)
        let testJson1: Data? = """
         {
            "people": [
                {
                    "id": 1,
                    "firstName": "Dave",
                    "lastName": "Stothers",
                    "usermane": "stotherd"
                },
                {
                    "id": 2,
                    "firstName": "Arthur",
                    "lastName": "Dent",
                    "username": "iForgotMyTowel"
                }
            ]
        }
        """.data(using: .utf8)
        var people = [PeopleParser.Person]()
        do {
            people = try PeopleParser().parseJson(data: testJson1!)!
        }
        catch {
            XCTAssertTrue(people.isEmpty)
        }
        XCTAssertTrue(people.isEmpty)
        
        //Test missing username
        let testJson2: Data? = """
         {
            "people": [
                {
                    "id": 1,
                    "firstName": "Dave",
                    "lastName": "Stothers"
                },
                {
                    "id": 2,
                    "firstName": "Arthur",
                    "lastName": "Dent",
                    "username": "iForgotMyTowel"
                }
            ]
        }
        """.data(using: .utf8)
        people = [PeopleParser.Person]()
        do {
            people = try PeopleParser().parseJson(data: testJson2!)!
        }
        catch {
            XCTAssertTrue(people.isEmpty)
        }
        XCTAssertTrue(people.isEmpty)
        
        //Test wrong type for username
        let testJson3: Data? = """
        {
            "people": [
                {
                    "id": 1,
                    "firstName": "Dave",
                    "lastName": "Stothers",
                    "username": true
                },
                {
                    "id": 2,
                    "firstName": "Arthur",
                    "lastName": "Dent",
                    "username": "iForgotMyTowel"
                }
            ]
        }
        """.data(using: .utf8)
        people = [PeopleParser.Person]()
        do {
            people = try PeopleParser().parseJson(data: testJson3!)!
        }
        catch {
            XCTAssertTrue(people.isEmpty)
        }
    }
    
    func testEstablishmentParserThrowsOnEmptyJSON() {
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let testJson: Data? = """
        {
            
        }
        """.data(using: .utf8)
        var people = [PeopleParser.Person]()
        do {
            people = try PeopleParser().parseJson(data: testJson!)!
        }
        catch {
            XCTAssertTrue(people.isEmpty)
        }
        XCTAssertTrue(people.isEmpty)
    }
    
    func testPerformanceEstablishments() {
        // Testing timeing of parsing
        self.measure {
            let testJson: Data? = """
            {
                "people": [
                    {
                        "id": 1,
                        "firstName": "Dave",
                        "lastName": "Stothers",
                        "username": "stotherd"
                    },
                    {
                        "id": 2,
                        "firstName": "Arthur",
                        "lastName": "Dent",
                        "username": "iForgotMyTowel"
                    }
                ]
            }
            """.data(using: .utf8)
            do {
                _ = try PeopleParser().parseJson(data: testJson!)!
            }
            catch {
                XCTFail()
            }
        }
    }
    
}
