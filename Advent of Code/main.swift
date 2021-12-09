//
//  main.swift
//  No rights reserved.
//

import Foundation
import Algorithms

func main() {
    let fileUrl = URL(fileURLWithPath: "./aoc-input")
    guard let inputString = try? String(contentsOf: fileUrl, encoding: .utf8) else { fatalError("Invalid input") }
    
    let lines = inputString.components(separatedBy: "\n")
        .filter { !$0.isEmpty }

    var points = [[Int]]()

    var tempLine = [Int]()
    for _ in 0 ..< lines[0].count + 2 { tempLine.append(10) }

    points.append(tempLine)
    lines.forEach { line in
        var row = Array(line).map(String.init).map { Int($0)! }
        row = [10] + row + [10]
        points.append(row)
    }
    points.append(tempLine)

    var lowPointHeights = [Int]()

    for (i, j) in product(1 ..< points.count - 1, 1 ..< points[0].count - 1) {
        if points[i][j] < points[i][j-1] &&
            points[i][j] < points[i][j+1] &&
            points[i][j] < points[i-1][j] &&
            points[i][j] < points[i+1][j] {
            lowPointHeights.append(points[i][j])
            continue
        }
    }

    let result = lowPointHeights.map { $0 + 1 }.reduce(0, +)
    print(result)
}

main()
