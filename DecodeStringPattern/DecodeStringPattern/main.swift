//
//  main.swift
//  DecodeStringPattern
//
//  Created by Anthony Gonsalves on 14.09.20.
//  Copyright © 2020 Anthony Gonsalves. All rights reserved.
//

import Foundation

func decode(main: String, currentIndex: inout Int, multiplier: Int, substring: String) -> String {
    if currentIndex >= main.count {
        return ""
    }
    
    var result = ""
    let characters = Array(main)
    while currentIndex < characters.count {
        
        // When we encounter ] then we copy the substring encountered within the braces
        // and use it till the multiplier.
        if characters[currentIndex] == "]" {
            var subs = ""
            for _ in 0..<multiplier {
                subs = result + subs
            }
            currentIndex += 1
            return subs
        }
        
        // When a number is encountered, this number will be taken as the multiplier for the upcoming
        // string between the braces.
        if characters[currentIndex].isNumber == true {
            var miniMultiplier = 0
            // Extract the numbers.
            while characters[currentIndex].isNumber {
                miniMultiplier = miniMultiplier * 10 + Int("\(characters[currentIndex])")!
                currentIndex += 1
            }
            
            // Once we encounter [, begin a recursion by taking the multiplier that was calculated earlier.
            if characters[currentIndex] == "[" {
                currentIndex += 1
                result += decode(main: main, currentIndex: &currentIndex,
                                 multiplier: miniMultiplier, substring: "")
            }
        }

        // For the alphabets/letters simply append to the result.
        while currentIndex < characters.count,  characters[currentIndex].isLetter {
            result += "\(characters[currentIndex])"
            currentIndex += 1
        }
    }
    
    return result
}

// Driver function.
func main() {
    print("Demonstration of decoding a string.")
    print("More details of this problem can be found at:")
    print("https://leetcode.com/problems/decode-string/")
    let input = "a2[b]3[c]m2[n2[o3[p]]]qrst"
    var index = 0
    let decoded = decode(main: input, currentIndex: &index, multiplier: 1, substring: "")
    print("For the given input: \(input)")
    print("The decoded string is = \(decoded)")
}

// Drive
main()
