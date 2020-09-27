//
//  main.swift
//  RegularExpressionMatching
//
//  Created by Anthony Gonsalves on 27.09.20.
//  Copyright © 2020 Anthony Gonsalves. All rights reserved.
//

import Foundation

/*
 Key to this algorithm
 
 We create a matrix of size i * j
 
 i - index of the actual string
 j - index of the regex
 
 conditions:
 1. if string[i] == pattern[j] or '.' then
        TruthTable[i,j] = TruthTable[i-1][j-1]
    We consider whether the string is matching the pattern without the current character.
 
 2. if pattern[j] == '*' then
        1. we consider 0 occurance of the pattern[i] works or not. i.e
        TruthTable[i, j] = TruthTable[i, j-2]
        or
        2. if pattern[j - 1] == string[i - 1], here we consider if 1 or more occurance
        works or not. i.e
        TruthTable[i, j] = TruthTabe[i-1, j]
*/


func regularExpression(mainString: String, patternString: String) -> Bool {
    
    var mainCharacters = Array(mainString)
    var patternCharacters = Array(patternString)
    mainCharacters.insert(Character("_"), at: 0)
    patternCharacters.insert(Character("_"), at: 0)

    var truthTable = Array(repeating: Array(repeating: false, count: patternString.count + 1),
                           count: mainString.count + 1)

    for i in 0...mainString.count {
        truthTable[i][0] = false
    }
    
    for j in 0...patternString.count {
        truthTable[0][j] = false
    }
    
    truthTable[0][0] = true // "" string is equal to empty pattern ""

    for i in 1...mainString.count {
        for j in 1...patternString.count {
            if mainCharacters[i] == patternCharacters[j] || patternCharacters[j] == "." {
                truthTable[i][j] = truthTable[i-1][j-1]
            } else if patternCharacters[j] == "*" {
                if truthTable[i][j-2] == true {
                    truthTable[i][j] = true
                } else if patternCharacters[j - 1] == mainCharacters[i] {
                    truthTable[i][j] = truthTable[i-1][j]
                }
            } else {
                truthTable[i][j] = false
            }
        }
    }

    // The last cell will contain the computed answer.
    return truthTable[mainString.count][patternString.count]
}

// Driver function
func main() {
    print("Demonstration of the Regular expression matcher.")
    print("More information about the problem can be found at:")
    print("https://leetcode.com/problems/regular-expression-matching/")
    print("Also refer: https://www.youtube.com/watch?v=l3hda49XcDE")
    
    let mainString = "xaabyc"
    let pattern = "xa*b.c"
    
    print("\n\nFor given main string: \(mainString) and pattern: \(pattern)")
    print("Does the regular expression hold: \(regularExpression(mainString: mainString, patternString: pattern))")
}

// Drive
main()
