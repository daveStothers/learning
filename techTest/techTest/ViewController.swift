//
//  ViewController.swift
//  techTest
//
//  Created by David Stothers on 25/05/2019.
//  Copyright © 2019 Stotherd. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    //Generate global variables the UI relies on
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.accessibilityIdentifier = "mainView" //used by tests
    }
}

