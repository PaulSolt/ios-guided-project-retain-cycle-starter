//
//  LinkedList.swift
//  LinkedList
//
//  Created by Paul Solt on 2/27/20.
//  Copyright © 2020 Paul Solt. All rights reserved.
//

import Foundation

// Double Linked List Node

//          head                tail
//   nil <- Bob  <->  Max  <->  Sue -> nil
class Node: Equatable, CustomStringConvertible {
    var next: Node?         // owns the memory for next element in collection
    weak var prev: Node?   // weak zeroing reference (no ownership)
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
