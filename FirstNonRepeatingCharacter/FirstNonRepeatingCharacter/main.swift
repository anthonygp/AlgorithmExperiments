//
//  main.swift
//  FirstNonRepeatingCharacter
//
//  Created by Anthony Gonsalves on 30.08.20.
//  Copyright © 2020 Anthony Gonsalves. All rights reserved.
//

import Foundation

func solutionUsingHashMap(for givenString: String) -> String? {
    var hashMap: [Character: Int] = [:]
    
    for element in givenString {
        hashMap[element] = 1 + (hashMap[element] ?? 0)
    }
    
    for element in givenString {
        if hashMap[element] == 1 {
            return "\(element)"
        }
    }
    
    return nil
}

// This will not work for integer inputs
func solutionUsingNoHashMap(for givenString: String) -> String? {
    // Total ascii values
    var charCountArray: [UInt8] = Array(repeating: 0, count: 128)
    
    for element in givenString {
        if let ascii = element.asciiValue {
            charCountArray[Int(ascii)] = 1 + charCountArray[Int(ascii)]
        }
    }
    
    for element in givenString {
        if let ascii = element.asciiValue, charCountArray[Int(ascii)] == 1 {
            return "\(element)"
        }
    }
    return nil
}

/// Driver
func main() {
    print("Demonstrate a first unique character in a string")
    print("More information can be found at ")
    print("https://leetcode.com/problems/first-unique-character-in-a-string/")
    let input = "aabbccdee"
    print("Input : \(input)")
    let output = solutionUsingNoHashMap(for: input)
    print("Output element: \(output ?? "nil")")
}

main()


