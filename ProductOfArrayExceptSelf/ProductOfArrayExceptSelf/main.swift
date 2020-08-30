//
//  main.swift
//  ProductOfArrayExceptSelf
//
//  Created by Anthony Gonsalves on 30.08.20.
//  Copyright © 2020 Anthony Gonsalves. All rights reserved.
//

import Foundation


func productOfArrayExceptSelf(input: [Int]) -> [Int] {
    var resultArray: [Int] = []
    let lProductArray = leftProductArray(input: input)
    let rProductArray = rightProductArray(input: input)
    for i in 0..<input.count {
        let leftProductElement = (i == 0) ? 1: lProductArray[i-1]
        let rightProductElement = (i == input.count-1) ? 1: rProductArray[i+1]
        resultArray.append(leftProductElement * rightProductElement)
    }
    return resultArray
}

func leftProductArray(input: [Int]) -> [Int] {
    var lProductArray: [Int] = []
    for i in 0..<input.count {
        let lastProduct = lProductArray.last ?? 1
        lProductArray.append(lastProduct * input[i])
    }
    return lProductArray
}

func rightProductArray(input: [Int]) -> [Int] {
    var rProductArray: [Int] = []
    for i in (0..<input.count).reversed() {
        let lastProduct = rProductArray.first ?? 1
        rProductArray.insert(lastProduct * input[i], at: 0)
    }
    return rProductArray
}

/// Driver
func main() {
    print("Demonstrate a product array except self.")
    print("More information can be found at ")
    print("https://leetcode.com/problems/product-of-array-except-self/")
    let input = [1, 2, 3, 4]
    print("Input array: \(input)")
    let output = productOfArrayExceptSelf(input: input)
    print("Output array: \(output)")
}

main()
