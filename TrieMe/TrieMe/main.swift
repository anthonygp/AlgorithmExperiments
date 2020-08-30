//
//  main.swift
//  TrieMe
//
//  Created by Anthony Gonsalves on 26.08.20.
//  Copyright © 2020 Anthony Gonsalves. All rights reserved.
//

import Foundation

class Trie {
    class Node {
        let value: String
        var children: [String: Node] = [:]
        var wordEndCount = 0
        init(value: String) {
            self.value = value
        }
    }
    
    let root = Node(value: "")
    
    func insert(word: String) {
        var currentNode = root
        for element in word {
            let singleLetter = "\(element)"
            var childNode: Node?
            childNode = currentNode.children[singleLetter]
            if childNode == nil {
                let node = Node(value: singleLetter)
                currentNode.children[singleLetter] = node
                childNode = node
            }
            currentNode = childNode!
        }
        currentNode.wordEndCount += 1
    }
    
    func search(word: String) -> Bool {
        var currentNode = root
        for element in word {
            let singleLetter = "\(element)"
            if let childNode = currentNode.children[singleLetter]{
                currentNode = childNode
            } else {
                return false
            }
        }
        return currentNode.wordEndCount > 0
    }
    
    func delete(word: String) -> Bool {
        return delete(word: word, currentIndex: 0, currentNode: root)
    }
    
    private func delete(word: String, currentIndex: Int, currentNode: Node) -> Bool {
        if currentIndex == word.count {
            currentNode.wordEndCount -= 1
            if currentNode.wordEndCount != 0 {
                return false
            }
            return currentNode.children.count == 0 && currentNode.wordEndCount <= 0
        }
        let singleLetter = "\(Array(word)[currentIndex])"
        guard let childNode = currentNode.children[singleLetter] else {
            return false
        }
        
        let shouldDelete = delete(word: word, currentIndex: currentIndex+1, currentNode: childNode)
        if shouldDelete {
            currentNode.children.removeValue(forKey: singleLetter)
            return currentNode.children.count == 0 && currentNode.wordEndCount <= 0
        }
        return false
    }
    
}

func main() {
    print("Demonstrate the implementation of Trie datastructure.")
    print("More information can be found at ")
    print("https://leetcode.com/problems/implement-trie-prefix-tree/")

    let words = ["lorem", "loreal", "user", "usher"]
    let trie = Trie()
    for word in words {
        trie.insert(word: word)
    }
    
    var searchWord = "user1"
    print("The word \(searchWord) is \(trie.search(word: searchWord) ? "present": "not present")")
    
    searchWord = "user"
    print("The word \(searchWord) is \(trie.search(word: searchWord) ? "present": "not present")")
    
    print("The word \(searchWord) is \(trie.delete(word: searchWord) ? "deleted" : "not deleted")")
}

main()
