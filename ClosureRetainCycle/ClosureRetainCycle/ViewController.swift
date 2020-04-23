//
//  ViewController.swift
//  ClosureRetainCycle
//
//  Created by Paul Solt on 2/27/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // instance variable
    let name = "Tim"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // local variable
        let phone = Phone()
        let person = Person(name: "John", phone: phone)

        person.answerPhone()
        
        // Question: Did the memory get cleaned up?
    } // all local variables go out of scope, and get cleaned up here
}

