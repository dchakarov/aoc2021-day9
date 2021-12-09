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
        }
    }

    let result = lowPointHeights.map { $0 + 1 }.reduce(0, +)
    print(result)
}

func main2() {
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

    var lowPoints = [(Int, Int)]()

    for (i, j) in product(1 ..< points.count - 1, 1 ..< points[0].count - 1) {
        if points[i][j] < points[i][j-1] &&
            points[i][j] < points[i][j+1] &&
            points[i][j] < points[i-1][j] &&
            points[i][j] < points[i+1][j] {
            lowPoints.append((i, j))
        }
    }

    var lowPointBasinSizes = [Int]()

    for lowPoint in lowPoints {
        lowPointBasinSizes.append(calcBasinSize(for: lowPoint, points: points))
    }

    print(lowPointBasinSizes.max(count: 3).reduce(1, *))
}

func calcBasinSize(for point: (Int, Int), points: [[Int]]) -> Int {
    var pointsToCheck = [point]
    var visitedPoints = [(Int, Int)]()
    while !pointsToCheck.isEmpty {
        let nextPoint = pointsToCheck.removeFirst()
        visitedPoints.append(nextPoint)
        let adjPoints = adjacentNicePoints(to: nextPoint, points: points)
            .filter { point in
                !visitedPoints.contains { $0 == point }
                && !pointsToCheck.contains { $0 == point }
            }
        pointsToCheck.append(contentsOf: adjPoints)
    }
    return visitedPoints.count
}

func adjacentNicePoints(to point: (x: Int, y: Int), points: [[Int]]) -> [(Int, Int)] {
    var result = [(Int, Int)]()
    if points[point.x - 1][point.y] < 9 {
        result.append((point.x - 1, point.y))
    }
    if points[point.x + 1][point.y] < 9 {
        result.append((point.x + 1, point.y))
    }
    if points[point.x][point.y - 1] < 9 {
        result.append((point.x, point.y - 1))
    }
    if points[point.x][point.y + 1] < 9 {
        result.append((point.x, point.y + 1))
    }

    return result
}

main2()
