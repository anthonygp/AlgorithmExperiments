//
//  main.swift
//  WaterArea
//
//  Created by Anthony Gonsalves on 13.09.20.
//  Copyright © 2020 Anthony Gonsalves. All rights reserved.
//

import Foundation

func waterArea(info: [Int]) -> [Int] {
    // Initialize a pseudo array, which represents the water filled.
    var filledWaterArea = Array(repeating: 0, count: info.count)
    
    // We then use the last known tallest pillar to fill.
    var lastTallestPillarIndex = 0
    
    for i in 0..<info.count {
        let element = info[i]
        let lastTallestPillar = info[lastTallestPillarIndex]
        // If there is no pillar we continue.
        if element == 0 {
            continue
        }
        
        /*
         There are 2 conditions to be checked.
         1. If the current pillar is tallest. Then the water area would be filling only till the last known tallest
            pillar.
         2. If the current pillar is smaller than the tallest pillar, then we would fill the earlier gaps by
            the current pillars height and we do so only if the current pillar is taller than the previous pillar.
         */
        
        if lastTallestPillar < element {
            fill(waterArea: &filledWaterArea,
                 blockInfo: info, blockValue: lastTallestPillar,
                 startIndex: lastTallestPillarIndex, endIndex: i)
            lastTallestPillarIndex = i
        } else {
            fill(waterArea: &filledWaterArea, blockInfo: info,
                 blockValue: element,
                 startIndex: lastTallestPillarIndex, endIndex: i)
        }
    }
    return filledWaterArea
}

func fill(waterArea: inout [Int], blockInfo: [Int], blockValue: Int, startIndex: Int, endIndex: Int) {
    /*
     We fill the water area only if the current block is shorter in height as compared to the tallest on the
     right.
     */
    var index = endIndex - 1
    while index > startIndex {
        if blockInfo[index] < blockInfo[endIndex] {
            waterArea[index] = blockValue - blockInfo[index]
        }
        index -= 1
    }
    
}

/// Driver function.
func main() {
    print("Demonstration of simple puzzle.")
    print("Given a array of pillar information, Find the water area that can be covered.")
    print("More information about the problem can be found at:")
    print("https://leetcode.com/problems/trapping-rain-water/")
    //let input =    [0, 8, 0, 0, 5, 0, 0, 10, 0, 0, 1, 1, 0, 3]
    //let expected = [0, 0, 8, 8, 3, 8, 8, 0, 3, 3, 2, 2, 3, 0]
    
    let input = [0, 1, 0, 2, 1, 0, 1, 3, 2, 1, 2, 1]
    let expected = [0, 0, 1, 0, 1, 2, 1, 0, 0, 1, 0, 0]
    print("Given array information: \(input)")
    print("The expected result is \(expected) and summing \(expected.reduce(0, +))")
    let logicOutput = waterArea(info: input)
    print("The output produced is \(logicOutput) and summing \(logicOutput.reduce(0, +))")
}

main()
