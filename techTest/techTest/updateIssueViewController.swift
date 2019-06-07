//
//  updateTicketViewController.swift
//  techTest
//
//  Created by David Stothers on 06/06/2019.
//  Copyright © 2019 Stotherd. All rights reserved.
//

import UIKit

class updateIssueViewController: UIViewController, UITextFieldDelegate {

    var id = 0
    var issueTitle = ""
    var fullDescription = ""
    var assignee = 0
    var people = [PeopleParser.Person]()
    
    override func viewDidLoad() {
        
        assigneeTextField.delegate = self
        super.viewDidLoad()
        titleInputField.text = issueTitle
        descriptionField.text  = fullDescription
        if (id == 0) {
            submitIssueButton.setTitle("Submit ticket", for: .normal)
        }
        else {
            submitIssueButton.setTitle("Update Ticket", for: .normal)
        }
        for person in people {
            suggestions.append(person.username)
            if person.id == assignee {
                assigneeTextField.text = person.username
            }
        }
        view.accessibilityIdentifier = "updateIssueView"
    }
    
    @IBOutlet weak var assigneeTextField: UITextField!
    @IBOutlet weak var descriptionField: UITextView!
    @IBOutlet weak var titleInputField: UITextField!
    
    @IBOutlet weak var submitIssueButton: UIButton!
    
    @IBAction func assigneeTextFieldSelected(_ sender: Any) {
        
    }
    var suggestions = [String]()
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        return !autoCompleteText( in : textField, using: string, suggestions: suggestions)
    }
    
    func autoCompleteText( in textField: UITextField, using string: String, suggestions: [String]) -> Bool {
        if !string.isEmpty,
            let selectedTextRange = textField.selectedTextRange,
            selectedTextRange.end == textField.endOfDocument,
            let prefixRange = textField.textRange(from: textField.beginningOfDocument, to: selectedTextRange.start),
            let text = textField.text( in : prefixRange) {
            let prefix = text + string
            let matches = suggestions.filter {
                $0.hasPrefix(prefix)
            }
            if (matches.count > 0) {
                textField.text = matches[0]
                if let start = textField.position(from: textField.beginningOfDocument, offset: prefix.count) {
                    textField.selectedTextRange = textField.textRange(from: start, to: textField.endOfDocument)
                    return true
                }
            }
        }
        return false
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func submitIssue(_ sender: Any) {
        submitIssueButton.setTitle("Submitting", for: .normal)
        issueSubmitted()
    }
    
    func processResult(body: Data) {
        submitIssueButton.setTitle("Update Ticket", for: .normal)
    }
    
    
    func issueSubmitted() {
        var titleText = ""
        if let text: String = titleInputField.text {
            titleText = text
        }
        
        if titleText.count == 0 {
            return
        }
        
        var descriptionText = ""
        if let text: String = descriptionField.text {
            descriptionText = text
        }
        
        if descriptionText.count == 0 {
            return
        }
        
        if let index = suggestions.firstIndex(of: assigneeTextField.text!) {
            assignee = people[index].id
        }
        
       
        if (id == 0) {
            let data = ["id": "\(id)", "title": "\(titleText)", "description": "\(descriptionText)", "person": "\(assignee)" ]
            _ = ApiRequests().makeApiRequest(endpoint: "createbug.php", body: data, callback: processResult)
        }
        else {
            let data = ["id": "\(id)", "title": "\(titleText)", "fullDescription": "\(descriptionText)", "assignee": "\(assignee)" ]
            _ = ApiRequests().makeApiRequest(endpoint: "changebug.php", body: data, callback: processResult)

        }
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation

}
