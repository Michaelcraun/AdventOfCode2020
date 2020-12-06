import UIKit

typealias Answers = String

func parse() -> [Answers] {
    let report = Bundle.main.path(forResource: "CustomDeclarations", ofType: "txt")!
    let content = try! String(contentsOfFile: report)
    return content.components(separatedBy: "\n\n")
}

let data = parse()
print(data)
