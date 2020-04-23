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
        // capture list [weak x, y]
        
        self.phone.whenPhoneRings { [weak self] in
            // Early exit if self is nil, otherwise unwrap
            guard let self = self else { return }
            
            print("<Answering phone>")
            print("Hello this is \(self.name)")
        }
        
        // func whenPhoneRings(self: Person)
    }
}

class Phone {
    
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
