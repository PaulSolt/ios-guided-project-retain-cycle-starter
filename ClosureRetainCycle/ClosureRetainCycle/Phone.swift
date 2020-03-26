//
//  Phone.swift
//  ClosureRetainCycle
//
//  Created by Paul Solt on 2/27/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

import Foundation

class Person {
    let name: String // strong
    let phone: Phone // strong
    
    init(name: String, phone: Phone) {
        self.name = name
        self.phone = phone
        
        setupPhone()
    }
    
    func answerPhone() {
        phone.call()
    }
    
    deinit {
        print("deint: \(self)")
    }
    
    func setupPhone() {
        // unowned = implicitly unwrapped optional (risky like force unwrapping)
        self.phone.whenPhoneRings { [weak self] in // capture list
            
            // Guard allows us to focus on the algorithm below without
            // having to worry about optional values
            guard let self = self else {
                print("Person doesn't exist")
                return
            }
            // How can I prevent logic from executing here if self is nil
            
            print("<Answering phone>")
            print("Hello this is \(self.name)") // capture self strongly
        }
    }
}

class Phone {
    
    // Closure that has a strong reference
    private var phoneAnswerHandler: (() -> Void)? // strong

    deinit {
        print("deint: \(self)")
    }
    
    func call() {
        self.phoneAnswerHandler?()
    }
    
    func whenPhoneRings(answer: @escaping (() -> Void)) {
        phoneAnswerHandler = answer
    }
}
