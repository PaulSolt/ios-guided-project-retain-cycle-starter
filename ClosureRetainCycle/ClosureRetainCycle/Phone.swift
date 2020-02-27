//
//  Phone.swift
//  ClosureRetainCycle
//
//  Created by Paul Solt on 2/27/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

import Foundation

class Person {
    let name: String  // strong: name: 1
    let phone: Phone  // strong: phone: 1
    
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
        self.phone.whenPhoneRings { [weak self] in
            print("<Answering phone>")
            print("Hello this is \(self?.name ?? "nil")") // self: 2
        }
    }
}

class Phone {
    
    private var phoneAnswerHandler: (() -> Void)?  // strong: 1

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
