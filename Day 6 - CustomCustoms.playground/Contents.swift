import UIKit

typealias Answers = String

extension Answers {
    static var questions: String = "abcdefghijklmnopqrstuvwxyz"
    
    var individualAnswers: [Answers] {
        return self.components(separatedBy: "\n")
    }
    
    func removingDuplicates() -> Answers {
        var trimmedAnswers: Answers = ""
        for char in self {
            if char != "\n" && !trimmedAnswers.contains(char) {
                trimmedAnswers.append(char)
            }
        }
        return trimmedAnswers
    }
    
    func commonAnswers() -> Answers {
        var common: Answers = ""
        let individual = self.individualAnswers
        for question in Answers.questions {
            if individual.allContains(question) {
                common.append(question)
            }
        }
        return common
    }
}

extension Array where Element == Answers {
    func allContains(_ question: Character) -> Bool {
        for answers in self {
            if !answers.contains(question) {
                return false
            }
        }
        return true
    }
}

func parse() -> [Answers] {
    let report = Bundle.main.path(forResource: "CustomDeclarations", ofType: "txt")!
    let content = try! String(contentsOfFile: report)
    return content.components(separatedBy: "\n\n")
}

func count() -> Int {
    var current: Int = 0
    for answers in data {
        current += answers.removingDuplicates().count
    }
    return current
}

func countForCommonAnswers() -> Int {
    var current: Int = 0
    for answers in data {
        current += answers.commonAnswers().count
    }
    return current
}

let data = parse()
print(count())
print(countForCommonAnswers())
