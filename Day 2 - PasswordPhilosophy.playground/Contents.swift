import UIKit

typealias Data = (parameter: String, value: String)

func parse() -> [Data] {
    let report = Bundle.main.path(forResource: "Passwords", ofType: "txt")!
    let content = try! String(contentsOfFile: report)
    let components = content.components(separatedBy: "\n")
    var data: [Data] = []
    components.forEach({
        let components = $0.components(separatedBy: ": ")
        data.append((components[0], components[1]))
    })
    return data
}

func validPasswordsFromOldCompany(containedIn data: [Data]) -> [Data] {
    var valid: [Data] = []
    for (parameter, value) in data {
        var mutableParameter = parameter
        
        // Get identifying character and remove extraneous character
        let delimiter = mutableParameter.removeLast()
        mutableParameter.removeLast()
        
        // Compile amount of acceptable characters
        let components = mutableParameter.components(separatedBy: "-")
        let range = Int(components[0])!...Int(components[1])!
        
        // Filter value to obtain all occurences of delimiter within value, then compare count of found delimiters to compiled range
        let delimiters = value.filter({ $0 == delimiter })
        if range.contains(delimiters.count) {
            valid.append((parameter: parameter, value: value))
        }
    }
    return valid
}

func validPasswordsForOTC(containedIn data: [Data]) -> [Data] {
    var valid: [Data] = []
    for (parameter, value) in data {
        var mutableParameter = parameter
        
        // Get identifying character and remove extraneous character
        let delimiter = mutableParameter.removeLast()
        mutableParameter.removeLast()
        
        // Compile indecies
        let components = mutableParameter.components(separatedBy: "-")
        let firstIndex = value.index(value.startIndex, offsetBy: Int(components[0])! - 1)
        let secondIndex = value.index(value.startIndex, offsetBy: Int(components[1])! - 1)
        
        // Compare characters and indecies and append if either case is valid
        if value[firstIndex] == delimiter && value[secondIndex] != delimiter {
            valid.append(Data(parameter, value))
        } else if value[firstIndex] != delimiter && value[secondIndex] == delimiter {
            valid.append(Data(parameter, value))
        }
    }
    return valid
}

let data = parse()
let validPasswordFromOldCompany = validPasswordsFromOldCompany(containedIn: data)
print(validPasswordFromOldCompany.count)                                                // 467
let validPasswords = validPasswordsForOTC(containedIn: data)
print(validPasswords.count)                                                             // 441
