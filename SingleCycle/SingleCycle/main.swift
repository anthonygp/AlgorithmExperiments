//
//  main.swift
//  SingleCycle
//
//  Created by Anthony Gonsalves on 25.07.20.
//  Copyright © 2020 Anthony Gonsalves. All rights reserved.
//

import Foundation

print("Hello, World!")


func hasSingleCycle(input: [Int]) -> Bool {
    
    var uniques = Set<Int>()
    
    for (index, element) in input.enumerated() {
        let visitedIndex = calculate(offset: element, length: input.count, index: index)
        uniques.insert(visitedIndex)
    }
    
    return uniques.count == input.count
}

func calculate(offset: Int, length: Int, index: Int) -> Int {
    let jumpedIndex = (index + offset) % length
    if jumpedIndex < 0 {
        return (length ) + jumpedIndex
    }
    return jumpedIndex
}

let input = [2, 3, 1, -4, -4, 2]
let isProvidedArrayCydle = hasSingleCycle(input: input)
print(isProvidedArrayCydle ? "Provided Array is a cycle": "Provided Array is not a cycle")
