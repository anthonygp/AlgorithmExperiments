//
//  main.swift
//  ParenthesisPermutation
//
//  Created by Anthony Gonsalves on 22.08.20.
//  Copyright © 2020 Anthony Gonsalves. All rights reserved.
//

import Foundation

/// Normal recursion DFS
func permutationOfParenthesis(numberOfPairs: Int, result: inout [String], runningleftParenthesis: Int,
                              runningRightParenthesis: Int, runningBrackets: String = "") {
    if runningleftParenthesis == numberOfPairs, runningRightParenthesis == numberOfPairs {
        result.append(runningBrackets)
        return
    }
    
    if runningleftParenthesis < numberOfPairs {
        permutationOfParenthesis(numberOfPairs: numberOfPairs, result: &result,
                                 runningleftParenthesis: runningleftParenthesis + 1,
                                 runningRightParenthesis: runningRightParenthesis,
                                 runningBrackets: runningBrackets + "(")
    }
    if runningRightParenthesis < runningleftParenthesis {
        permutationOfParenthesis(numberOfPairs: numberOfPairs, result: &result,
                                 runningleftParenthesis: runningleftParenthesis,
                                 runningRightParenthesis: runningRightParenthesis + 1,
                                 runningBrackets: runningBrackets + ")")
    }
}


/// Normal BFS. Non-recursive
extension Array {
    mutating func enqueue(element: Element) { self.append(element) }
    mutating func dequeue() -> Element? { isEmpty ? nil : removeFirst() }
}

func bfsPermutationOfParenthesis(numberOfPairs: Int) -> [String] {
    struct Node {
        let value: String
        let runningleftParenthesis: Int
        let runningRightParenthesis: Int
    }
        
    let seedNode = Node(value: "", runningleftParenthesis: 0, runningRightParenthesis: 0)
    var queue = [Node]()
    queue.enqueue(element: seedNode)
    
    var result = [String]()
    while !queue.isEmpty, let currentNode = queue.dequeue() {
        if currentNode.runningleftParenthesis == numberOfPairs,
            currentNode.runningRightParenthesis == numberOfPairs {
            result.append(currentNode.value)
        }
        
        if currentNode.runningleftParenthesis < numberOfPairs {
            let childNode = Node(value: currentNode.value + "(",
                                 runningleftParenthesis: currentNode.runningleftParenthesis + 1,
                                 runningRightParenthesis: currentNode.runningRightParenthesis)
            queue.enqueue(element: childNode)
        }
        if currentNode.runningRightParenthesis < currentNode.runningleftParenthesis {
            let childNode = Node(value: currentNode.value + ")",
                                            runningleftParenthesis: currentNode.runningleftParenthesis,
                                            runningRightParenthesis: currentNode.runningRightParenthesis + 1)
            queue.enqueue(element: childNode)
        }
    }
    return result
}

/// Normal DFS without recursion.
extension Array {
    mutating func push(element: Element) { append(element) }
    mutating func pop() -> Element? { popLast() }
}

func dfsWithoutRecursionPermutationOfParenthesis(numberOfPairs: Int) -> [String] {
    struct Node {
        let value: String
        let runningleftParenthesis: Int
        let runningRightParenthesis: Int
    }
        
    let seedNode = Node(value: "", runningleftParenthesis: 0, runningRightParenthesis: 0)
    var stack = [Node]()
    stack.push(element: seedNode)
    
    var result = [String]()
    while !stack.isEmpty, let currentNode = stack.pop() {
        if currentNode.runningleftParenthesis == numberOfPairs,
            currentNode.runningRightParenthesis == numberOfPairs {
            result.append(currentNode.value)
        }
        
        if currentNode.runningleftParenthesis < numberOfPairs {
            let childNode = Node(value: currentNode.value + "(",
                                 runningleftParenthesis: currentNode.runningleftParenthesis + 1,
                                 runningRightParenthesis: currentNode.runningRightParenthesis)
            stack.push(element: childNode)
        }
        if currentNode.runningRightParenthesis < currentNode.runningleftParenthesis {
            let childNode = Node(value: currentNode.value + ")",
                                            runningleftParenthesis: currentNode.runningleftParenthesis,
                                            runningRightParenthesis: currentNode.runningRightParenthesis + 1)
            stack.push(element: childNode)
        }
    }
    return result
}

/// Driver function
func main() {
    print("Details about the problem can be found at \n https://www.geeksforgeeks.org/print-all-combinations-of-balanced-parentheses/")
    print("\n\n")
    let numberOfBracketsPairs = 3
    print("Valid brackets that can be formed from \(numberOfBracketsPairs) pairs:")
    print((0..<numberOfBracketsPairs).reduce("", {res, _ in "\(res) ()" }))
    var result: [String] = []
    permutationOfParenthesis(numberOfPairs: numberOfBracketsPairs,
                             result: &result, runningleftParenthesis: 0, runningRightParenthesis: 0)
    print(result)
}

main()
