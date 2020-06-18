//
//  Phone.swift
//  ClosureRetainCycle
//
//  Created by Paul Solt on 2/27/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

import Foundation

class Person {
    let name: String
    let phone: Phone
    
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
        //self.phone.whenPhoneRings(answer: <#T##(() -> Void)##(() -> Void)##() -> Void#>)
        // Use capture list to break retain cycle: []
        self.phone.whenPhoneRings { [weak self] in
//            guard let self = self else { return }
            
            print("<Answering phone>")
            print("Hello this is \(self?.name)") // person: 2
        }
    }
}

class Phone {
    
    private var phoneAnswerHandler: (() -> Void)?

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
