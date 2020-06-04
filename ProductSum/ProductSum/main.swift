//
//  main.swift
//  ProductSum
//
//  Created by Anthony Gonsalves on 14/05/20.
//  Copyright © 2020 Anthony Gonsalves. All rights reserved.
//

import Foundation

print("Hello, World!")


let input: [Any] = [5, 2, [7, -1], 3, [6, [-13, 8], 4]]
// Calculated as: 5 + 2 + 2 * (7 - 1) + 3 + 2 * (6 + 3 * (-13 + 8) + 4)) = 12


func productSum(array: [Any], multiplier: Int) -> (Int, String) {
    if array.isEmpty {
        return (0, "")
    }

    var result = (0, "")
    for element in array {
        if let element = element as? [Any] {
            let preResult = productSum(array: element, multiplier: multiplier + 1)
            result = (result.0 + preResult.0 * multiplier,
                      result.1 + " + ( \(preResult.1) )")
        } else if let element = element as? Int {

            result = (result.0 + element * multiplier,
                      "\(result.1) + \(element) * \(multiplier)")
        }
    }

    return result
}

let result = productSum(array: input, multiplier: 1)

print("result is \(result.0) also text representation is \(result.1)")

