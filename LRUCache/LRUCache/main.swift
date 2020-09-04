//
//  main.swift
//  LRUCache
//
//  Created by Anthony Gonsalves on 04.09.20.
//  Copyright © 2020 Anthony Gonsalves. All rights reserved.
//

import Foundation

class LRUCache<Key: Hashable, Value: Equatable & CustomStringConvertible> {
    let maxCapacity: Int
    var lookupHashTable: [Key: Node<Value>] = [:]
    private let head = Node<Value>()
    private let tail = Node<Value>()
    
    init(withMaxCapacity capacity: Int) {
        self.maxCapacity = capacity
        self.head.next = tail
        self.tail.previous = head
    }

    class Node<Value: Equatable> {
        let data: Value?
        
        var next: Node?
        var previous: Node?
        
        init(data: Value? = nil) {
            self.data = data
        }
    }

    func put(value: Value, key: Key) {
        if let node = get(key: key) {
            moveFront(node: node)
        } else {
            // check if reached capacity, delete last node if needed.
            if lookupHashTable.count == maxCapacity,
                let lastNode = tail.previous {
                remove(node: lastNode)
            }
            let newNode = Node(data: value)
            lookupHashTable[key] = newNode
            appendToHead(node: newNode)
        }
    }
    
    func get(key: Key) -> Node<Value>? {
        if let node = lookupHashTable[key] {
            moveFront(node: node)
            return node
        }
        return nil
    }
    
    private
    func moveFront(node: Node<Value>) {
        remove(node: node)
        appendToHead(node: node)
    }
    
    private
    func appendToHead(node: Node<Value>) {
        let nextNode = head.next
        head.next = node
        node.previous = head
        node.next = nextNode
        nextNode?.previous = node
    }
    
    private
    func remove(node: Node<Value>) {
        let nextNode = node.next
        let previousNode = node.previous
        
        previousNode?.next = nextNode
        nextNode?.previous = previousNode
        
        node.previous = nil
        node.next = nil
    }
    
    func displayCache() {
        var cacheRepresentation = "head"
        var nextNode = head.next
        while nextNode != nil {
            cacheRepresentation += "->\(nextNode!.data)"
            nextNode = nextNode?.next
        }
        print(cacheRepresentation)
    }
}

// Driver function
func main() {
    print("Implementation of LRU cache.")
    print("For more details see https://www.geeksforgeeks.org/lru-cache-implementation/")
    let lruCache = LRUCache<String, Int>(withMaxCapacity: 5)
    lruCache.put(value: 10, key: "Ten")
    lruCache.put(value: 20, key: "Twenty")
    lruCache.put(value: 30, key: "Thrity")
    lruCache.put(value: 40, key: "Forty")
    lruCache.put(value: 50, key: "Fifty")
    lruCache.displayCache()
    
    // Using 20 again, Expected to put this on front.
    lruCache.put(value: 20, key: "Twenty")
    lruCache.displayCache()

    // Inserting 60, expected to cache evict 10 from the last.
    lruCache.put(value: 60, key: "Sixty")
    lruCache.displayCache()
}

main()
