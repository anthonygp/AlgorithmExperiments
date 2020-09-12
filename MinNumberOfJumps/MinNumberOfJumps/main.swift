//
//  main.swift
//  MinNumberOfJumps
//
//  Created by Anthony Gonsalves on 12.09.20.
//  Copyright © 2020 Anthony Gonsalves. All rights reserved.
//

import Foundation

func minimumJumps(numbers: [Int]) -> Int {
    if numbers.count == 0 {
        return 0
    }
    
    var minJumps: [Int] = Array(repeating: Int.max, count: numbers.count)
    minJumps[0] = 0
    print("Tracing matrix")
    for i in 1..<numbers.count {
        var j = i - 1
        while j >= 0 {
            // Check if the number present at j is capable of making a jump untill or beyond i-th index.
            if numbers[j] + j >= i {
                // store the value relating to the jump.
                minJumps[i] = min(minJumps[i], minJumps[j] + 1)
            }
            j -= 1
        }
        print(minJumps)
    }
    
    if minJumps.count != numbers.count {
        return Int.min
    }
    
    // Space complexity is O(n) and time complexity is O(n*n)
    return minJumps.last!
}


/// Driver function.
func main() {
    print("Demonstration of the Minimum jumps needed to reach the end of the sequence.")
    print("More information can be found at:")
    print("https://leetcode.com/problems/jump-game-ii/")
    
    print("For the given input: ")
    let input = [2, 3, 1, 1, 4]
    print(input)
    
    print("The minimum jumps that can be made is \(minimumJumps(numbers: input))")
}

main()
