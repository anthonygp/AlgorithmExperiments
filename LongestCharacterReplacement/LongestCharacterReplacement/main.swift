//
//  main.swift
//  LongestCharacterReplacement
//
//  Created by Anthony Gonsalves on 17.09.20.
//  Copyright © 2020 Anthony Gonsalves. All rights reserved.
//

import Foundation


func longestCharacterReplacement(string: String, replacementAllowed: Int) -> Int {
    
    var begin = 0, end = 0, maxOccuranceCount = 0, maxLength = 0
    var occurance: [Character: Int] = [:]
    
    let mainCharacters = Array(string)
    while end < mainCharacters.count {
        let currentChar = mainCharacters[end]
        
        // if the count is nil, 0 is returned.
        let currentCharCount = occurance[currentChar] ?? 0
        occurance[currentChar] = currentCharCount + 1
        maxOccuranceCount = max(occurance[currentChar]!, maxOccuranceCount)
        // We always hold the maximum repeatative count, because it enough to calculate whether the
        // current window is maximum than the previously encountered window then adjust the window accordingly.
        while end - begin - maxOccuranceCount + 1 > replacementAllowed {
            let windowBeginChar = mainCharacters[begin]
            occurance[windowBeginChar] = occurance[windowBeginChar]! - 1
            begin = begin + 1
        }
        
        let newlyAdjustedWindowSize = end - begin + 1
        maxLength = max(newlyAdjustedWindowSize, maxLength)
        
        end = end + 1
    }
    
    return maxLength
}

// Driver function
func main() {
    print("Demonstration of longest possible repitative string after k character replacements.")
    print("More information can be found at:")
    print("https://leetcode.com/problems/longest-repeating-character-replacement/")
    
    //let input = "AABABBA"
    let input = "AAABCDEFGA"
    let replacementAllowed = 2
    print("Given input: \(input)")
    print("Given allowed repeatation: \(replacementAllowed)")
    let result = longestCharacterReplacement(string: input, replacementAllowed: replacementAllowed)
    print("Maximum possilbe repeatative character count will be: \(result)")
}

main()
