//
//  main.swift
//  PowerSet
//
//  Created by Anthony Gonsalves on 12.08.20.
//  Copyright © 2020 Anthony Gonsalves. All rights reserved.
//

import Foundation

print("Hello, World!")

/**
 https://www.geeksforgeeks.org/power-set/
 */

func powerSet<T: CustomStringConvertible>(input: [T]) -> [Any] {
    var runningSet: [Any] = []
    runningSet.append([])
    
    for element in input {
        var previousRunningSet = runningSet
        for runningSetElement in runningSet {
            var mutableSetElement = runningSetElement as! [Any]
            mutableSetElement.append(element)
            previousRunningSet.append(mutableSetElement)
        }
        runningSet = previousRunningSet
    }
    return runningSet
}

func recursivePowerSet<T: CustomStringConvertible>(input: inout [T], uptoLength count: Int) -> [Any] {
    if count == 0 {
        return [[]]
    }
    let runningSet = recursivePowerSet(input: &input, uptoLength: count - 1)
    let element = input[count-1]
    var previousRunningSet = runningSet
    for runningSetElement in runningSet {
        var mutableSetElement = runningSetElement as! [Any]
        mutableSetElement.append(element)
        previousRunningSet.append(mutableSetElement)
    }
    
    return previousRunningSet
}

var set1 = ["a", "b", "c"]
print("powerset of \(set1) is \n \(recursivePowerSet(input: &set1, uptoLength: 3))\n")

let set2 = [1, 2, 3]
print("powerset of \(set2) is \n \(powerSet(input: set2))")

