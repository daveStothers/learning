//
//  ListIssuesViewController.swift
//  techTest
//
//  Created by David Stothers on 04/06/2019.
//  Copyright © 2019 Stotherd. All rights reserved.
//

import UIKit

class ListIssuesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //table view delegate methods.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return issuesShown.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuseIdentifier")! //1.
        let text = issuesShown[indexPath.row].title
        cell.textLabel?.text = text
        return cell
    }
    
    func reloadTableView(){
        issuesShown = [IssuesParser.Bug]()
        for issue in issues {
            switch stateShown {
            case "Closed":
                if issue.bugOpen == 0 {
                    issuesShown.append(issue)
                }
            case "Open":
                if issue.bugOpen == 1 {
                    issuesShown.append(issue)
                }
            default:
                issuesShown.append(issue)
            }
        }
        tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        updateSelectedData(issue: issuesShown[indexPath.row])
        selectedIssue = indexPath
    }
    
    

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var issueTitle: UILabel!
    @IBOutlet weak var issueStatus: UILabel!
    @IBOutlet weak var issueTimeStamp: UILabel!
    @IBOutlet weak var issueDescription: UILabel!
    @IBOutlet weak var changeIssueStateButton: UIButton!
    @IBOutlet weak var changeShownIssuesButton: UIButton!
    
    @IBOutlet weak var updateIssueButton: UIButton!
    
    
    @IBAction func changeIssueState(_ sender: Any) {
        //Insert API call to update issue state
        changeState(id: issuesShown[selectedIssue.row].id, state: issuesShown[selectedIssue.row].bugOpen)
    }
    
    @IBAction func changeShownIssues(_ sender: Any) {
        switch stateShown {
        case "All":
            changeShownIssuesButton.setTitle("Open tickets", for: .normal)
            stateShown = "Open"
        case "Open":
            changeShownIssuesButton.setTitle("Closed tickets", for: .normal)
            stateShown = "Closed"
        default:
            changeShownIssuesButton.setTitle("All tickets", for: .normal)
            stateShown = "All"
        }
        reloadTableView()
    }
    
    
    var stateShown = "All"
    var pickerData = [String]()
    var result = ""
    var issues = [IssuesParser.Bug]()
    var issuesShown = [IssuesParser.Bug]()
    var people = [PeopleParser.Person]()
    var scheme = 1
    var pickResult = ""
    var selectedIssue: IndexPath = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        view.accessibilityIdentifier = "issuesListView"
        get_data()
        updateIssueButton.setTitle("Create Ticket", for: .normal)
    }
    
    func get_data() {
        var requestResult = ApiRequests().makeApiRequest(endpoint: "getbugs.php", callback: callbackIssueJson)
        updateApiRequestResult(apiResult: "\(requestResult) issues data")
        requestResult = ApiRequests().makeApiRequest(endpoint: "getpeople.php", callback: callbackPeopleJson)
        updateApiRequestResult(apiResult: "\(requestResult) all data")
        
    }
    
    func updateApiRequestResult(apiResult: String)
    {
        statusLabel.text = apiResult
    }
    //callback for the network request to get the authority list
    func callbackIssueJson(data: Data) {
        do {
            try issues = IssuesParser().parseJson(data: data)!
        }
        catch {
            updateApiRequestResult(apiResult: "Failed to get data")
            return
        }
        updateApiRequestResult(apiResult: "Loaded data")
        reloadTableView()
    }
    
    //callback for the network request to get the authority list
    func callbackForStateChange(data: Data) {
        get_data()
        issueTitle.isHidden = true
        issueStatus.isHidden = true
        issueTimeStamp.isHidden = true
        issueDescription.isHidden = true
        changeIssueStateButton.isHidden = true
        updateIssueButton.isHidden = true
        updateApiRequestResult(apiResult: "Loaded data")
        updateIssueButton.setTitle("Create Ticket", for: .normal)
    }
    
    func callbackPeopleJson(data: Data) {
        do {
            try people = PeopleParser().parseJson(data: data)!
        }
        catch {
            updateApiRequestResult(apiResult: "Failed to get data")
            return
        }
        updateApiRequestResult(apiResult: "Loaded data")
        reloadTableView()
    }
    
    //method for changing the open/closed state of an issue
    public func changeState(id: Int, state: Int) {
        var requestResult = ""
        let data = ["id": "\(id)" ]
        if state == 0 {
            requestResult = ApiRequests().makeApiRequest(endpoint: "reopenBug.php", body: data, callback: callbackForStateChange)
        }
        else {
            requestResult = ApiRequests().makeApiRequest(endpoint: "closeBug.php", body: data, callback: callbackForStateChange)
        }
        updateApiRequestResult(apiResult: "\(requestResult) issues data")
    }
    
    //Override the prepare delegate method to pass data to the subsequent view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let vc = segue.destination as? updateIssueViewController
        {
            if issueTitle.isHidden == false {
                vc.issueTitle = issuesShown[selectedIssue.row].title
                vc.id = issuesShown[selectedIssue.row].id
                vc.fullDescription = issuesShown[selectedIssue.row].fullDescription
                vc.assignee = issuesShown[selectedIssue.row].assignee
            }
            vc.people = people
        }
    }
    
    //Show the data from the selected row
    func updateSelectedData(issue: IssuesParser.Bug) {
        let label1 = "Issue \(issue.id): \(issue.title)"
        issueTitle.text = label1
        let label2 = "Description: \n\(issue.fullDescription)"
        issueDescription.text = label2
        var state = "Closed"
        if issue.bugOpen > 0 {
            state = "Open"
            changeIssueStateButton.setTitle("Close Ticket", for: .normal)
        }
        else {
            changeIssueStateButton.setTitle("Reopen Ticket", for: .normal)
        }
        var assignee = "None"
        for person in people {
            if person.id == issue.assignee {
                assignee = person.username
            }
        }
        let label3 = "State:  \n\(state) -  Assignee: \(assignee)"
        issueTimeStamp.text = label3
        let label4 = "Opened: \n\(issue.timestamp)"
        issueStatus.text = label4
        issueTitle.isHidden = false
        issueStatus.isHidden = false
        issueTimeStamp.isHidden = false
        issueDescription.isHidden = false
        changeIssueStateButton.isHidden = false
        updateIssueButton.isHidden = false
        updateIssueButton.setTitle("Update Ticket", for: .normal)
    }
    
}
