//
//  ViewController.swift
//  ClosureRetainCycle
//
//  Created by Paul Solt on 2/27/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let phone = Phone() // phone: 1
        var person: Person? = Person(name: "John", phone: phone) // person: 1 + 1

    //        person.answerPhone()
        
        person = nil        // if the person doesn't exist, should we still call them?
        phone.call()
        
        // Question: Did the memory get cleaned up?
        
        // person: 1
        // phone: 2
    } // person: 0, phone: 0
}

