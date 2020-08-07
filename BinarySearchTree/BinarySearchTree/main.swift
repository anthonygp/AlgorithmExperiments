//
//  main.swift
//  BinarySearchTree
//
//  Created by Anthony Gonsalves on 25/04/20.
//  Copyright © 2020 Anthony Gonsalves. All rights reserved.
//

import Foundation

print("Demonstration of Binary search tree")



class BinarySearchTree<Value: Comparable>: CustomStringConvertible {

    class Node {
        var value: Value
        var left: Node?
        var right: Node?

        init(value: Value) {
            self.value = value
        }
    }

    var rootNode: Node?

    func insert(value: Value) {
        let node = insert(value: value, parentNode: rootNode)
        print(node.value)
    }

    @discardableResult private
    func insert(value: Value, parentNode: Node?) -> Node {
        guard let aparentNode = parentNode else {
            let node = Node(value: value)
            if rootNode == nil { rootNode = node }
            return node
        }

        switch value < aparentNode.value {
        case true:
            aparentNode.left = insert(value: value, parentNode: aparentNode.left)
        case false:
            aparentNode.right = insert(value: value, parentNode: aparentNode.right)
        }
        return aparentNode
    }

    let spaceBetweenDifferentLevels = 10
    var description: String {
        var toBeReturned = ""

        func printOnConsole(parentNode: Node?, space: Int) {
            guard let aparentNode = parentNode else {
                return
            }

            let nextLevelspace = space + spaceBetweenDifferentLevels

            printOnConsole(parentNode: aparentNode.left, space: nextLevelspace)

            (0...nextLevelspace).forEach { _ in toBeReturned.append(" ") }
            toBeReturned.append("\(aparentNode.value)\n")

            printOnConsole(parentNode: aparentNode.right, space: nextLevelspace)
        }

        printOnConsole(parentNode: rootNode, space: 0)
        return toBeReturned
    }

    func search(value: Value) -> Node? {
        return search(value: value, parentNode: rootNode)
    }

    private
    func search(value: Value, parentNode: Node?) -> Node? {
        guard let aparentNode = parentNode else { return nil }

        if aparentNode.value == value {
            return aparentNode
        }

        switch value < aparentNode.value {
        case true:
            return search(value: value, parentNode: aparentNode.left)
        case false:
            return search(value: value, parentNode: aparentNode.right)
        }
    }

    func delete(value: Value, parentNode: Node?) -> Node? {
        guard let aparentNode = parentNode else { return nil }
        if aparentNode.value < value {
            aparentNode.left = delete(value: value, parentNode: aparentNode.left)
        } else if aparentNode.value > value {
            aparentNode.right = delete(value: value, parentNode: aparentNode.right)
        } else {
            if aparentNode.left == nil, aparentNode.right == nil {
                return nil
            } else if let childLeftNode = aparentNode.left, aparentNode.right == nil {
                aparentNode.value = childLeftNode.value
                aparentNode.left = nil
                return aparentNode
            } else if let childRightNode = aparentNode.right, aparentNode.left == nil {
                aparentNode.value = childRightNode.value
                aparentNode.right = nil
                return aparentNode
            } else {
                //Find the min in right sub tree
                if let minRightNode = findMin(aparentNode.right) {
                    aparentNode.value = minRightNode.value
                    aparentNode.right = delete(value: minRightNode.value, parentNode: aparentNode.right)
                    return aparentNode
                }
            }
        }
        return nil
    }

    func findMin(_ parentNode: Node?) -> Node? {
        guard let aparentNode = parentNode else { return nil }
        if aparentNode.left == nil {
            return aparentNode
        }
        return findMin(aparentNode.left)
    }
}

extension BinarySearchTree where Value == Int {
    func findClosestValue(targetNumber: Value) -> Value {
        return findClosestValue(node: rootNode, target: targetNumber, closest: Int.max)
    }

    func findClosestValue(node: Node?, target: Value, closest: Value) -> Value {
        guard let currentNode = node else {
            return closest
        }

        if currentNode.value == closest {
            return closest
        }

        var refClosest = closest
        if abs(currentNode.value - target) < abs(target - closest) {
            refClosest = currentNode.value
        }

        if currentNode.value < target {
            return findClosestValue(node: currentNode.right, target: target, closest: refClosest)
        } else {
            return findClosestValue(node: currentNode.left, target: target, closest: refClosest)
        }
    }
}

/// Implementation of DFS Running Sum of a branch
extension BinarySearchTree where Value == Int {
    func findBranchSum() {
        branchSum(node: rootNode, runningSum: 0, branchNodes: [])
    }

    func branchSum(node: Node?, runningSum: Int, branchNodes: [Int]) {
        guard let currentNode = node else {
            return
        }

        let currentSum = runningSum + currentNode.value
        let newNodes = branchNodes + [currentNode.value]

        if currentNode.left == nil, currentNode.right == nil {
            print("running sum \(currentSum), from branch nodes \(newNodes)")
        }

        branchSum(node: currentNode.left, runningSum: currentSum, branchNodes: newNodes)
        branchSum(node: currentNode.right, runningSum: currentSum, branchNodes: newNodes)
    }

    func showInDFS() {
        dfs(node: rootNode)
    }

    func dfs(node: Node?) {
        guard let currentNode = node else {
            return
        }
        print(currentNode.value)
        dfs(node: currentNode.left)
        dfs(node: currentNode.right)
    }
}





let bst = BinarySearchTree<Int>()

let numbers = [24, 25, 28, 30, 29, 27]

for number in numbers {
    print("Inserting... \(number)")
    bst.insert(value: number)
}

let exsistingNode = bst.search(value: 27)
print("exsisting node \(exsistingNode)")

let nonExsistingNode = bst.search(value: 26)
print("exsisting node \(nonExsistingNode)")

let target = 31
let closest = bst.findClosestValue(targetNumber: target)
print("closest node for \(target) is \(closest)")

print(bst)

bst.findBranchSum()
bst.showInDFS()
