//
//  main.swift
//  LowestCommonAncestor
//
//  Created by Anthony Gonsalves on 07.08.20.
//  Copyright © 2020 Anthony Gonsalves. All rights reserved.
//

import Foundation

/**
 https://www.geeksforgeeks.org/lowest-common-ancestor-binary-tree-set-1/
 */

print("Hello, World!")

class Node<T: Hashable>: CustomStringConvertible {
    var left: Node?
    var right: Node?
    let value: T
    
    init(value: T) {
        self.value = value
    }
    
    var description: String { "\(value)"   }
}

let root = Node(value: "A")
let B = Node(value: "B")
let C = Node(value: "C")
let D = Node(value: "D")
let E = Node(value: "E")
let F = Node(value: "F")
let G = Node(value: "G")
let H = Node(value: "H")
let I = Node(value: "I")

root.left = B; root.right = C
B.left = D; B.right = E
D.left = H; D.right = I
C.left = F; C.right = G

@discardableResult
func find<T: Hashable>(value: T, root: Node<T>?, path: inout [Node<T>]) -> Bool {
    guard let currentNode = root else { return false }
    
    if value == currentNode.value {
        return true
    }
    
    if find(value: value, root: currentNode.left, path: &path) {
        path.append(currentNode)
        return true
    } else if find(value: value, root: currentNode.right, path: &path) {
        path.append(currentNode)
        return true
    }
    
    _ = path.popLast()

    return false
}

func lowestCommonAncestor<T: Hashable>(root: Node<T>?, childOne: Node<T>, childTwo: Node<T>) -> Node<T>? {
    var pathOne =  [Node<T>]()
    find(value: childOne.value , root: root, path: &pathOne)
    var pathTwo =  [Node<T>]()
    find(value: childTwo.value , root: root, path: &pathTwo)
    
    if pathOne.count > pathTwo.count {
        while pathOne.count != pathTwo.count {
            pathOne.removeFirst()
        }
    } else if pathOne.count < pathTwo.count {
        while pathOne.count != pathTwo.count {
            pathTwo.removeFirst()
        }
    }
    
    var lastParent: Node<T>?
    while !pathTwo.isEmpty {
        let popOne = pathOne.popLast()
        let popTwo = pathTwo.popLast()
        if popOne?.value != popTwo?.value {
            break
        }
        lastParent = popOne
    }
    
    return lastParent
}

let commonAncestor = lowestCommonAncestor(root: root, childOne: H, childTwo: E)
print(commonAncestor ?? "No common ancestor found")
