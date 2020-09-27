//
//  main.swift
//  PrimeSieves
//
//  Created by Anthony Gonsalves on 27.09.20.
//  Copyright © 2020 Anthony Gonsalves. All rights reserved.
//

import Foundation

/*
 Given N numbers, the numbers series less than √N are taken into account and those numbers
 which are divisible by the number series are marked stating that they are not a prime
 number set. The resultant numbers are prime numbers.
*/

func primeSieves(until N: Int) -> [Int] {
    
    var isPrimes: [Bool] = []
    for _ in 0...N {
        isPrimes.append(true)
    }
    
    let sqrtN = Int(sqrt(Float(N)))
    for i in 2...sqrtN {
        for j in stride(from: i * i, to: N+1, by: i) {
            isPrimes[j] = false
        }
    }
    
    var primes: [Int] = []
    for i in 2...N {
        if isPrimes[i] == true {
            primes.append(i)
        }
    }
    
    return primes
}

// Driver function
func main() {
    print("Prime numbers list up until N")
    print("This program is the demonstration of Sieves of Error-Toss-The-Knees(Eratosthenes)")
    let N = 100
    print("The prime numbers up until \(N) are:")
    print(primeSieves(until: N))
}

// Drive
main()
