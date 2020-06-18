//
//  LinkedListTests.swift
//  LinkedListTests
//
//  Created by Paul Solt on 2/27/20.
//  Copyright © 2020 Paul Solt. All rights reserved.
//

import XCTest

class LinkedListTests: XCTestCase {

    // TODO: Make this unit test pass. Fix the retain cycle and give me a check-mark if you figure
    // it out
    
    func testRemoveAllClearsMemory() {
        let list = LinkedList()
        var n1: Node? = Node(value: "One")
        var n2: Node? = Node(value: "Two")
        var n3: Node? = Node(value: "Three")
        
        weak var weakN1 = n1
        weak var weakN2 = n2
        weak var weakN3 = n3
        
        // head | n3 -> n2 -> n1 | tail
        
        list.insertFirst(n1!)
        list.insertFirst(n2!)
        list.insertFirst(n3!)

        list.printList()
        
        n1 = nil // Remove ownership from local variables
        n2 = nil
        n3 = nil
        
        list.removeAll() // clearing list should cleanup all nodes
        
        XCTAssertNil(weakN1)
        XCTAssertNil(weakN2)
        XCTAssertNil(weakN3)
        
        XCTAssertNil(list.head)
        XCTAssertNil(list.tail)
    }

}
