//
//  LinkedList.swift
//  LinkedList
//
//  Created by Paul Solt on 2/27/20.
//  Copyright © 2020 Paul Solt. All rights reserved.
//

import Foundation

// Double Linked List Node

// ----- Retain Cycle
//          head                tail
//   nil <- Bob  <->  Max  <->  Sue -> nil

// Retain cycle (next/prev are strong references)
//          head                        tail
//   nil <- Bob (2)  <->  Max (2)  <->  Sue (2) -> nil

// removeAll (set head/tail to nil) = BUG retain cycle!
//   nil <- Bob (1)  <->  Max (2)  <->  Sue (1) -> nil

//----- Fixing the Retain Cycle

// Retain cycle (next is strong, prev a weak references)
//          head                          tail
//   nil <- Bob (+1)  <->  Max (+1)  <->  Sue (+1+1) -> nil


//          head = nil                          tail
//   nil <- Bob (0)  <->  Max (0)  <->  Sue (0+0) -> nil

class Node: Equatable, CustomStringConvertible {
    var next: Node?
    var prev: Node? // break a retain cycle using the weak reference
    var value: String
    
    init(value: String) {
        self.value = value
    }
    
    var description: String {
        return "\(value)"
    }
    
    static func == (lhs: Node, rhs: Node) -> Bool {
        return lhs.value == rhs.value
    }
}

class LinkedList {
    private (set) var head: Node?
    private (set) var tail: Node?
    
    func insertFirst(_ node: Node) {
        if head == nil { // insert head
            node.prev = nil
            node.next = nil
            head = node
            tail = node
        } else { // insert at update head
            node.prev = nil
            node.next = head
            head?.prev = node
            head = node
        }
    }
    
    func remove(_ node: Node) {
        if head == node && tail == node {
            head = nil
            tail = nil
        } else if head == node {
            head = node.next
            head?.prev = nil
        } else if tail == node {
            tail = node.prev
            tail?.next = nil
        } else {
            let previous = node.prev
            let next = node.next
            previous?.next = next
            next?.prev = previous
        }
    }
    
    func removeAll() {
        head = nil
        tail = nil
    }
    
    func printList() {
        var node = head
        let headString = head != nil ? "\(head!)" : "nil"
        let tailString = tail != nil ? "\(tail!)" : "nil"
        print("head: \(headString)")
        while node != nil {
            print(node ?? "nil")
            node = node?.next
        }
        print("tail: \(tailString)")
    }
}
