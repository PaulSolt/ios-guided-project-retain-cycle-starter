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

        // local variables should go out of scope (ARC) after the closing
        // } at the end of viewDidLoad()
        
        let phone = Phone() // phone: 1,
        var person: Person? = Person(name: "John", phone: phone) // person: 2, closure: 1

        person?.answerPhone()
        person = nil
        phone.call()
        
        UIView.animate(withDuration: 2.0) { // closure gets cleaned up after 2 seconds
            self.view.backgroundColor = .systemBlue
        }
        // Question: Did the memory get cleaned up?
    }
}

