//
//  LinkedListTests.swift
//  LinkedListTests
//
//  Created by Paul Solt on 2/27/20.
//  Copyright © 2020 Paul Solt. All rights reserved.
//

import XCTest

class LinkedListTests: XCTestCase {

    func testRemoveAllClearsMemory() {
        let list = LinkedList()
        var n1: Node? = Node(value: "One") // n1: 1 // any var or let without weak is implicitly strong
        var n2: Node? = Node(value: "Two")
        var n3: Node? = Node(value: "Three")
        
        weak var weakN1 = n1        // weak reference will auto-nil: the value becomes nil if the object gets cleaned up
        weak var weakN2 = n2
        weak var weakN3 = n3
        
        // head | n3 -> n2 -> n1 | tail
        //        Three -> Two -> One
        list.insertFirst(n1!) // n1: 2
        list.insertFirst(n2!)
        list.insertFirst(n3!)

        list.printList()
        
        n1 = nil  // n1: 1 // Remove ownership from local variables
        n2 = nil
        n3 = nil
        
        list.removeAll() // n1: 0 // clearing list should cleanup all nodes
        
        XCTAssertNil(weakN1) // if nil, it worked, otherwise we have a memory leak!
        XCTAssertNil(weakN2)
        XCTAssertNil(weakN3)
        
        XCTAssertNil(list.head)
        XCTAssertNil(list.tail)
    }

}
