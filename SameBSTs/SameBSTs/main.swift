//
//  main.swift
//  SameBSTs
//
//  Created by Anthony Gonsalves on 11.09.20.
//  Copyright © 2020 Anthony Gonsalves. All rights reserved.
//

import Foundation

func compareBinaryTree(binary1: [Int], binary2: [Int]) -> Bool {
    if binary1.isEmpty, binary2.isEmpty {
        return true
    }
    
    if binary1.count != binary2.count || binary1[0] != binary2[0] {
        return false
    }
    
    // Less values compared to the root
    let binary1LowValues = valuesLessThan(value: binary1[0], array: binary1)
    let binary2LowValues = valuesLessThan(value: binary2[0], array: binary2)
    
    // High values compared to the root
    let binary1HighValues = valuesGreaterThan(value: binary1[0], array: binary1)
    let binary2HighValues = valuesGreaterThan(value: binary2[0], array: binary2)
    
    return compareBinaryTree(binary1: binary1LowValues, binary2: binary2LowValues) &&
        compareBinaryTree(binary1: binary1HighValues, binary2: binary2HighValues)
}

func valuesLessThan(value: Int, array: [Int]) -> [Int] {
    return array.filter { element in element < value }
}

func valuesGreaterThan(value: Int, array: [Int]) -> [Int] {
    return array.filter { element in element > value }
}

/// Driver function
func main() {
    print("Demonstration to check whether 2 Binary Search Trees are same or not. (Non traversal method in a list)")
    let binary1Array = [10, 15, 8, 12, 94, 81, 5, 2, 11]
    let binary2Array = [10, 8, 5, 15, 2, 12, 11, 94, 81]
    print("For given input")
    print("Binary Search Tree A: \(binary1Array)")
    print("Binary Search Tree B: \(binary2Array)")
    print("BinarySearchTreeA \(compareBinaryTree(binary1: binary1Array, binary2: binary2Array) ? "=" : "≠") BinarySearchTreeB")
}

main()

/*
 This is very easy approach. Traverse and compare the elememts 
class Node {
    let data: Int
    var left: Node?
    var right: Node?
    
    init(data: Int) {
        self.data = data
    }
}

func isEqual(subTreeANode: Node?, subTreeBNode: Node?) -> Bool {
    guard let subTreeANode = subTreeANode, let subTreeBNode = subTreeBNode else {
        return true
    }
    
    if subTreeANode.data != subTreeBNode.data {
        return false
    }
    
    return isEqual(subTreeANode: subTreeANode.left, subTreeBNode: subTreeBNode.right) &&
        isEqual(subTreeANode: subTreeANode.right, subTreeBNode: subTreeBNode.right)
}
*/
