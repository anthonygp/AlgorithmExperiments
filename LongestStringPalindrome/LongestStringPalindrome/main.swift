//
//  main.swift
//  LongestStringPalindrome
//
//  Created by Anthony Gonsalves on 23.08.20.
//  Copyright © 2020 Anthony Gonsalves. All rights reserved.
//

import Foundation

func longestPalindrome(for longString: String) -> String {
    
    let longStringCharacters = Array(longString)
    var maxLength = 0
    var maxPalidromeCenterIndex = -1
    for (index, _) in longStringCharacters.enumerated() {
        let oddLength = expandPalindrome(characters: longStringCharacters,
                                         midLeft: index, midRight: index)
        let evenLength = expandPalindrome(characters: longStringCharacters, midLeft: index, midRight: index + 1)
        
        let length = max(oddLength, evenLength)
        if length > maxLength {
            maxLength = length
            maxPalidromeCenterIndex = index
        }
    }
    let startIndex = maxPalidromeCenterIndex - (Int(ceil(Float(maxLength)/2)) - 1)
    let endIndex = maxPalidromeCenterIndex + (maxLength/2)
    return String(longStringCharacters[startIndex...endIndex])
}

func expandPalindrome(characters: [Character], midLeft: Int, midRight: Int) -> Int {
    var left = midLeft
    var right = midRight
    while left >= 0, right < characters.count, characters[left] == characters[right] {
        left -= 1
        right += 1
    }
    return right - (left + 1)
}

/// Driver function
func main() {
    let input = "raccar"
    print("Problems description can be found at \n https://leetcode.com/problems/longest-palindromic-substring/")
    print("Longest palindrome for the given string: \(input)")
    print(longestPalindrome(for: input))
}

main()

