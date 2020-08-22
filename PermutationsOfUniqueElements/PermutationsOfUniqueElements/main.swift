//
//  main.swift
//  PermutationsOfUniqueElements
//
//  Created by Anthony Gonsalves on 22.08.20.
//  Copyright © 2020 Anthony Gonsalves. All rights reserved.
//

import Foundation

func permutationsOf<T: Hashable>(input: [T], generated: inout [T]) {
    if generated.count == input.count {
        print(generated)
    }
    
    for element in input {
        if generated.contains(element) {
            continue
        }
        generated.append(element)
        permutationsOf(input: input, generated: &generated)
        generated.removeLast()
    }
}

/// Driver function
func main() {
    let input = ["A", "B", "C", "D"]
    print("Problems description can be found at \n https://leetcode.com/problems/permutations/")
    print("Permutations of elements \(input)")
    var generated = [String]()
    permutationsOf(input: input, generated: &generated)
}
main()
