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
        var person: Person? = Person(name: "John", phone: phone) // person: 1

        person?.answerPhone()
        person = nil
        
        phone.call()
        
        // Question: Did the memory get cleaned up?
    }
}

