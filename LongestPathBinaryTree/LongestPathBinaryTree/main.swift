//
//  main.swift
//  LongestPathBinaryTree
//
//  Created by Anthony Gonsalves on 10.09.20.
//  Copyright © 2020 Anthony Gonsalves. All rights reserved.
//

import Foundation

class BinaryTree {
    var root: Node?
    
    class Node {
        let value: Int
        var left: Node?
        var right: Node?
        
        init(value: Int) {
            self.value = value
        }
    }
    
    func longestPath() -> Int {
        var result = 0
        longestPath(node: root, result: &result)
        return result
    }
 
    // we do dfs and search.
    @discardableResult
    private func longestPath(node: Node?, result: inout Int) -> Int {
        guard let currentNode = node else { return 0 }
        
        let leftPathValue = longestPath(node: currentNode.left, result: &result)
        let rightPathValue = longestPath(node: currentNode.right, result: &result)
        
        // case 1: Weight of either of the children + current node, current node
        let case1 = max(leftPathValue, rightPathValue) + 1
        
        // case 2: Weight of children along with parent.
        let case2 = leftPathValue + rightPathValue + 1
        
        result = max(case1, case2)
        return case1
    }
}

// Driver function
func main() {
    print("Longest in Binary Tree")
    print("More information can be found at")
    
    typealias Node = BinaryTree.Node
    var node: Node
    node = Node(value: -1)
    let binaryTree = BinaryTree()
    binaryTree.root = node
    
    node.left = Node(value: 1)
    node.right = Node(value: 2)
    node.right?.right = Node(value: 3)

    node.left?.left = Node(value: 4)
    node.left?.right = Node(value: 5)
    
    node.left?.left?.left = Node(value: 8)
    node.left?.left?.left?.left = Node(value: 15)
    node.left?.left?.right = Node(value: 4)
    node.left?.right?.right = Node(value: -10)
    
    print("The expected value is 7 and calculated value is \(binaryTree.longestPath())")
}

main()
