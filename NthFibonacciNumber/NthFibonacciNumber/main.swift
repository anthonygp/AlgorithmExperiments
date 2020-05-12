//
//  main.swift
//  NthFibonacciNumber
//
//  Created by Anthony Gonsalves on 12/05/20.
//  Copyright © 2020 Anthony Gonsalves. All rights reserved.
//

import Foundation

print("Nth fibonacci number")

let N = 10

var ithNumber = 0

var iPlus1Number = 1

var result = 0

for _ in 1..<N {
    result = ithNumber + iPlus1Number
    ithNumber = iPlus1Number
    iPlus1Number = result
}

print("The \(N)th Fibonacci number is \(result)")


// Recursive

func fib(number: Int) -> Int {
    if number == 1 || number == 0 {
        return number
    }
    return fib(number: number-1) + fib(number: number-2)
}

print("The recursive solution for \(N)th fibonacci number is \(fib(number: N))")


// Memonisation

var fibMap = [Int: Int]()
func fibMemonisation(number: Int) -> Int {
    if number == 1 || number == 0 {
        return number
    }
    if let cachedFibNthNumber = fibMap[number] {
        return cachedFibNthNumber
    }

    let fibMinus1Number =  fibMemonisation(number: number-1)
    fibMap[number-1] = fibMinus1Number

    let fibMinus2Number = fibMemonisation(number: number-2)
    fibMap[number-2] = fibMinus2Number

    return fibMinus1Number + fibMinus2Number
}

print("The recursive solution for \(N)th fibonacci number using Memonisation is  \(fibMemonisation(number: N))")
