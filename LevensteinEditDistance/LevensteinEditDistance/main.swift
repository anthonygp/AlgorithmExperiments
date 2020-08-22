//
//  main.swift
//  LevensteinEditDistance
//
//  Created by Anthony Gonsalves on 22.08.20.
//  Copyright © 2020 Anthony Gonsalves. All rights reserved.
//

import Foundation

func levensteinEditDistanceBetween(stringA: String, stringB: String,
                                   costOfDelete: Int, costOfInsert: Int, costOfTransform: Int) -> Int {
    var costChart = Array(repeating: Array(repeating: 0, count: stringB.count + 1), count: stringA.count + 1)
    
    let charactersOfA = Array(stringA)
    let charactersOfB = Array(stringB)
    // cost of transforming "" -> `stringA`
    for (index, _) in stringA.enumerated() { costChart[index + 1][0] = index + 1 }

    for (index, _) in stringB.enumerated() { costChart[0][index + 1] = index + 1 }
    
    for row in 1...stringA.count {
        for column in 1...stringB.count {
            let computedCostOfTransformation = (charactersOfA[row - 1] == charactersOfB[column - 1]) ? 0 : costOfTransform
            costChart[row][column] = min(costChart[row - 1][column - 1] + computedCostOfTransformation,
                                         costChart[row][column - 1] + costOfInsert,
                                         costChart[row - 1][column] + costOfDelete)
        }
    }
    
    return costChart[stringA.count][stringB.count]
}

/// Driver function
func main() {
    print("""
    Demonstartion of Levenstein's edit distance between 2 strings. More details about the problem can be found at
    https://www.geeksforgeeks.org/edit-distance-dp-5/
    """)
    let stringA = "geek"
    let stringB = "greek"
    
    let editDistance = levensteinEditDistanceBetween(stringA: stringA, stringB: stringB, costOfDelete: 1, costOfInsert: 1, costOfTransform: 1)
    print("Edit distance between \(stringA) and \(stringB) is \(editDistance)")
}

main()
