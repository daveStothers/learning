//
//  PeopleParser.swift
//  techTest
//
//  Created by David Stothers on 04/06/2019.
//  Copyright © 2019 Stotherd. All rights reserved.
//

import Foundation

public class PeopleParser {
    
    // MARK: - Person
    struct People: Codable {
        let people: [Person]
    }
    
    // MARK: - Person
    public struct Person: Codable {
        let id: Int
        let firstName, lastName, username: String
    }
    public enum PeopleParser: Error {
        case badJson
    }
    
    
    //Parse the actual json, return a list of establishments. We're ignoring the Meta and links data, though the meta data could be used for security
    public func parseJson(data: Data) throws -> [Person]? {
        let decoder = JSONDecoder()
        guard let jsonPeople = try? decoder.decode(People.self, from: data) else {
            print("Error: Couldn't decode data into JsonPeople")
            throw PeopleParser.badJson
        }
        
        var persons = [Person]()
        for person in jsonPeople.people {
            print("- \(person.username)")
            persons.append(person)
        }
        return persons
    }
}

