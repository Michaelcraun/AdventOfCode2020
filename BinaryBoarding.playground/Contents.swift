import UIKit

typealias BoardingPass = String

extension BoardingPass {
    static let rowCount: Int = 127
    
    mutating func row(firstSeat: Int, lastSeat: Int) -> Int {
        let median = (lastSeat - firstSeat) / 2
        let decisiveValue = self.removeFirst()
        switch decisiveValue {
        case "F": return row(firstSeat: firstSeat, lastSeat: lastSeat - median - 1)
        case "B": return row(firstSeat: firstSeat + median + 1, lastSeat: lastSeat)
        default:
            self.insert(decisiveValue, at: self.startIndex)
            return firstSeat
        }
    }
    
    mutating func column(first: Int, last: Int) -> Int {
        let median = (last - first) / 2
        if self.count > 0 {
            let decisiveValue = self.removeFirst()
            switch decisiveValue {
            case "L": return column(first: first, last: last - median - 1)
            case "R": return column(first: first + median + 1, last: last)
            default: fatalError()
            }
        } else {
            return first
        }
    }
    
    mutating func seatID() -> Int {
        let row = self.row(firstSeat: 0, lastSeat: 127)
        let column = self.column(first: 0, last: 7)
        return (row * 8) + column
    }
}

func parse() -> [BoardingPass] {
    let report = Bundle.main.path(forResource: "BoardingPasses", ofType: "txt")!
    let content = try! String(contentsOfFile: report)
    return content.components(separatedBy: "\n")
}

func highest() -> Int {
    var highest: Int = 0
    for var pass in data {
        let seatID = pass.seatID()
        if seatID > highest {
            highest = seatID
        }
    }
    return highest
}

func mySeatID() -> Int {
    var foundSeatIDs: [Int] = []
    for var pass in data {
        let seatID = pass.seatID()
        foundSeatIDs.append(seatID)
    }
    
    let sortedIDs = foundSeatIDs.sorted()
    var missingIDs: [Int] = []
    var currentID: Int = 0
    for id in sortedIDs {
        if id != currentID + 1 {
            missingIDs.append(id - 1)
        }
        currentID = id
    }
    return missingIDs.last!
}



var data = parse()
print(highest())
print(mySeatID())
