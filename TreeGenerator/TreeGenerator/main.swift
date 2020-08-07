//
//  main.swift
//  TreeGenerator
//
//  Created by Anthony Gonsalves on 05.08.20.
//  Copyright © 2020 Anthony Gonsalves. All rights reserved.
//

import Foundation

print("Hello, World!")

let treeInfo =
[
    "nodes": [
        ["ancestor": nil, "id": "A", "name": "A"],
        ["ancestor": "A", "id": "B", "name": "B"],
        ["ancestor": "A", "id": "C", "name": "C"],
        ["ancestor": "B", "id": "D", "name": "D"],
        ["ancestor": "B", "id": "E", "name": "E"],
        ["ancestor": "C", "id": "F", "name": "F"],
        ["ancestor": "C", "id": "G", "name": "G"],
        ["ancestor": "D", "id": "H", "name": "H"],
        ["ancestor": "D", "id": "I", "name": "I"]
    ]
]

class AncestralTree: CustomStringConvertible {
    let value: String
    let id: String
    var ancestor: AncestralTree?
    
    init(info: [String: String?]) {
        value = (info["name"] ?? "") ?? ""
        id = (info["id"] ?? "") ?? ""
    }
    
    var description: String { "value = \(value), id = \(id), tree = \(ancestor)" }
}

func createAncestralTree(from treeInfo: [String: Any]) -> AncestralTree? {
    guard let nodesInfo = treeInfo["nodes"] as? [[String: String?]] else {
        return nil
    }
    
    var nodes = [AncestralTree]()

    for nodeInfo in nodesInfo {
        let node = AncestralTree(info: nodeInfo)
        let ancestor = nodes.first { nodeInfo["ancestor"] == $0.id }
        node.ancestor = ancestor
        nodes.append(node)
    }
    return nodes.first
}

let root = createAncestralTree(from: treeInfo)

