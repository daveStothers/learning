//
//  IssuesParser.swift
//  techTest
//
//  Created by David Stothers on 04/06/2019.
//  Copyright © 2019 Stotherd. All rights reserved.
//

import Foundation

public class IssuesParser {
    
    // MARK: - Issues
    struct Issues: Codable {
        let bugs: [Bug]
    }
    
    // MARK: - Bug
    public struct Bug: Codable {
        let id: Int
        let title, fullDescription: String
        let bugOpen, assignee: Int
        let timestamp: String
        
        enum CodingKeys: String, CodingKey {
            case id, title, fullDescription
            case bugOpen = "open"
            case assignee, timestamp
        }
    }
    public enum IssuesParser: Error {
        case badJson
    }
    
    //Parse the actual json, return a list of establishments. We're ignoring the Meta and links data, though the meta data could be used for security
    public func parseJson(data: Data) throws -> [Bug]? {
        let decoder = JSONDecoder()
        guard let jsonBugs = try? decoder.decode(Issues.self, from: data) else {
            print("Error: Couldn't decode data into JsonBugs")
            throw IssuesParser.badJson
        }
        
        var bugs = [Bug]()
        for bug in jsonBugs.bugs {
            bugs.append(bug)
        }
        return bugs
    }
}

