//
//  main.swift
//  ThreeLargestNumber
//
//  Created by Anthony Gonsalves on 04/06/20.
//  Copyright © 2020 Anthony Gonsalves. All rights reserved.
//

import Foundation

print("Hello, World!")

let someNumbers = [141, 1, 17, -7, -17, -27, 18, 541, 8, 7, 7]

func largestThreeNumbers(_ numbers: [Int]) -> [Int] {
    var threeLargest: [Int?] = [nil, nil, nil]

    for number in numbers {
        updateLargest(&threeLargest, number)
    }

    return threeLargest.compactMap { $0 }
}

func updateLargest(_ threeLargest: inout [Int?], _ number: Int) {
    if threeLargest[2] == nil {
        shiftAndUpdate(&threeLargest, number: number, index: 2)
    } else if threeLargest[1] == nil {
        shiftAndUpdate(&threeLargest, number: number, index: 1)
    } else if threeLargest[0] == nil {
        shiftAndUpdate(&threeLargest, number: number, index: 0)
    }

    if let thirdNumber = threeLargest[2], number > thirdNumber {
        shiftAndUpdate(&threeLargest, number: number, index: 2)
    } else if let secondNumber = threeLargest[1], number > secondNumber {
        shiftAndUpdate(&threeLargest, number: number, index: 1)
    } else if let firstNumber = threeLargest[0], number > firstNumber {
        shiftAndUpdate(&threeLargest, number: number, index: 0)
    }
}

func shiftAndUpdate(_ threeLargest: inout [Int?], number: Int, index: Int) {
    for i in 0...index {
        if i == index {
            threeLargest[i] = number
        } else {
            threeLargest[i] = threeLargest[i+1]
        }
    }
}


print("sorting numbers \(someNumbers)")
print(largestThreeNumbers(someNumbers))
