import UIKit

func twoRequiredIntegers() -> (Int, Int) {
    for expense in expenses {
        for e in expenses {
            if expense + e == 2020 {
                return (expense, e)
            }
        }
    }
    return (0, 0)
}

func threeRequiredIntegers() -> (Int, Int, Int) {
    for expense in expenses {
        for exp in expenses {
            for e in expenses {
                if expense + exp + e == 2020 {
                    return (expense, exp, e)
                }
            }
        }
    }
    return (0, 0, 0)
}

func parseReport() -> [Int] {
    let expenseReport = Bundle.main.path(forResource: "Expenses", ofType: "txt")!
    let reportContent = try! String(contentsOfFile: expenseReport)
    let components = reportContent.components(separatedBy: "\n")
    return components.compactMap({ Int($0) })
}

let expenses = parseReport()
let twoIntegers = twoRequiredIntegers()
let threeIntegers = threeRequiredIntegers()
let result = threeIntegers.0 * threeIntegers.1 * threeIntegers.2
print(result)
