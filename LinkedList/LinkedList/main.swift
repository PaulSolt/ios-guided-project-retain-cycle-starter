//
//  main.swift
//  LinkedList
//
//  Created by Paul Solt on 2/27/20.
//  Copyright © 2020 Paul Solt. All rights reserved.
//

import Foundation

// Test data to "use" large chunks of memory
let text = String(repeating: "Test", count: 10_000_000) // 10 million repeats = ~38 MB of text

var list = LinkedList()

for i in 0 ..< 25000 {
    // make each string unique by appending a number
    let node = Node(value: "\(i)" + text)
    list.insertFirst(node)
}

list.removeAll()

print("list.removeAll")
