
import Foundation

let input = [1, 5, 7, -1, 5]
print("input: \(input)")

struct Pair: Equatable, Hashable, CustomDebugStringConvertible {
    let a, b: Int

    var debugDescription: String { "(\(a), \(b))" }

    static func == (lhs: Self, rhs: Self) -> Bool {
       return (lhs.a == rhs.a && lhs.b == rhs.b) || (lhs.a == rhs.b && lhs.b == rhs.a)
    }
}

/**
 1. We create a unique elements map containing count of occurances of each element given in input
 2. For each element in the input, check whether the difference between the sum and the element exsists in the map as the key, if so then
    the input element and the difference will form the pair that sums up as the required sum.
 3. Count the occurances and also handle the duplicte elements.
 */

func pairs(from input: [Int], formingSum sum: Int) -> [Pair] {
    var duplicateInfo: [Int: Int] = [:]

    for i in input {
        let count = duplicateInfo[i, default: 0]
        duplicateInfo[i] = count + 1
    }

    var pairs: [Pair] = []
    for value in input {
        let diff = sum - value

        var count = duplicateInfo[diff, default: 0]

        if sum == 2 * value {
            count = count - 1
        }

        let currentPair = Pair(a: value, b: diff)
        if count != 0, pairs.contains(where: { $0 == currentPair }) == false {
            pairs.append(currentPair)
        }
    }

    return pairs
}

let allPairs = pairs(from: input, formingSum: 6)
print(allPairs)
