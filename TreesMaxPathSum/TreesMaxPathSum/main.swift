//
//  main.swift
//  TreesMaxPathSum
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
    
    func maxPathSum() -> Int {
        var result = 0
        maxPathSum(node: root, result: &result)
        return result
    }
    
    /// Returns the max possible value untill the node that is passed
    @discardableResult
    private func maxPathSum(node: Node?, result: inout Int) -> Int {
        guard let currentNode = node else {
            return 0
        }
        
        // We go depth first search, to know what can be the max possible value untill that node.
        let leftValue = maxPathSum(node: currentNode.left, result: &result)
        let rightValue = maxPathSum(node: currentNode.right, result: &result)
        
        // Case 1:
        let case1 = max(max(leftValue, rightValue) + currentNode.value, currentNode.value)
        
        // Case 2:
        let case2 = max(leftValue + rightValue + currentNode.value, currentNode.value)
        
        result = max(result, case1, case2)
        return case1
    }
}

// Driver function
func main() {
    print("Max sum of path in Binary Tree")
    print("More information can be found at")
    print("https://leetcode.com/problems/binary-tree-maximum-path-sum/")
    
    typealias Node = BinaryTree.Node
    var node: Node
    node = Node(value: -1)
    let binaryTree = BinaryTree()
    binaryTree.root = node
    
    node.left = Node(value: 1)
    node.right = Node(value: 2)
    
    node.left?.left = Node(value: 4)
    node.left?.right = Node(value: 5)
    
    node.left?.left?.left = Node(value: 8)
    node.left?.left?.right = Node(value: 4)
    node.left?.right?.right = Node(value: -10)
    
    print("The expected value is 18 and calculated value is \(binaryTree.maxPathSum())")
}

main()
