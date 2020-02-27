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
        
        // By default Swift uses strong references
        var n1: Node? = Node(value: "One")
        var n2: Node? = Node(value: "Two")
        var n3: Node? = Node(value: "Three")
        
        weak var weakN1 = n1
        weak var weakN2 = n2
        weak var weakN3 = n3
        
        // head | n3 -> n2 -> n1 | tail
        
        // Transfer of ownership to the collection
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
    
    func testNode() {
     
        // Both are strong references
        var left: Node? = Node(value: "Left") // left: 1
        var right: Node? = Node(value: "Right") // right: 1
        
        weak var weakLeft = left // left: 1
        weak var weakRight = right // right: 1
        
        // left (strong) -> <- (weak) right
        left?.next = right // right: 2
        right?.prev = left // left: 1

        // What happens when I make right nil?
        right = nil // right: 1
        left = nil  // left: 0, right: 0

        // Example: where both next/prev are strong references, we have a
        // retain cycle
    //        // left (strong) -> <- (weak) right
    //        left?.next = right // right: 2
    //        right?.prev = left // left: 2
    //
    //        // What happens when I make right nil?
    //        right = nil // right: 1
    //        left = nil  // left: 1, right: 1
        
        XCTAssertNil(weakLeft)
        XCTAssertNil(weakRight)
    }
    

}
