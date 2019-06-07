//
//  ListPeopleViewController.swift
//  techTest
//
//  Created by David Stothers on 04/06/2019.
//  Copyright © 2019 Stotherd. All rights reserved.
//

import UIKit

class ListPeopleViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //table delegate methods.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuseIdentifier")! //1
        let text = people[indexPath.row].username
        cell.textLabel?.text = text //3.
        return cell //4.
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let label1 = "Person \(people[indexPath.row].id): \(people[indexPath.row].username)"
        peopleUsername.text = label1
        let label2 = "Full name: \n\(people[indexPath.row].firstName) \(people[indexPath.row].lastName)"
        peopleName.text = label2
        peopleUsername.isHidden = false
        peopleName.isHidden = false
    }
    
    var result = ""
    var people = [PeopleParser.Person]()
    var scheme = 1
    var pickResult = ""
    
    @IBOutlet weak var peopleUsername: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var peopleName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        view.accessibilityIdentifier = "peopleListView"
        //get the data
        let requestResult = ApiRequests().makeApiRequest(endpoint: "getpeople.php", callback: callbackPeopleJson)
        updateApiRequestResult(apiResult: "\(requestResult) Users data")
        
        
    }
    
    func updateApiRequestResult(apiResult: String)
    {
        status.text = apiResult
    }

    //Parse the data and kick off an update for the table
    func callbackPeopleJson(data: Data) {
        do {
            try people = PeopleParser().parseJson(data: data)!
        }
        catch {
            updateApiRequestResult(apiResult: "Failed to get data")
            return
        }
        updateApiRequestResult(apiResult: "Loaded data")
        tableView.reloadData()
    }
}
