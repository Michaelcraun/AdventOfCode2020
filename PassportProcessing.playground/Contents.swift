import UIKit

typealias PassportData = [String : Any]

extension PassportData {
    var isValid: Bool {
        if !isValidBirthYear { return false }
        if !isValidExpirationYear { return false }
        if !isValidEyeColor { return false }
        if !isValidHairColor { return false }
        if !isValidHeight { return false }
        if !isValidIssueYear { return false }
        if !isValidPassportID { return false }
        return true
    }
    
    private var isValidBirthYear: Bool {
        if let birthYear = self["byr"] as? String, let year = Int(birthYear) {
            return (1920...2002).contains(year)
        }
        return false
    }
    private var isValidExpirationYear: Bool {
        if let expirationYear = self["eyr"] as? String, let year = Int(expirationYear) {
            return (2020...2030).contains(year)
        }
        return false
    }
    private var isValidEyeColor: Bool {
        if let eyeColor = self["ecl"] as? String {
            return eyeColor == "amb" || eyeColor == "blu" || eyeColor == "brn" || eyeColor == "gry" || eyeColor == "grn" || eyeColor == "hzl" || eyeColor == "oth"
        }
        return false
    }
    private var isValidHairColor: Bool {
        if let hairColor = self["hcl"] as? String {
            if hairColor.hasPrefix("#") && hairColor.count == 7 {
                return hairColor.dropFirst().range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
            }
        }
        return false
    }
    private var isValidHeight: Bool {
        if let height = self["hgt"] as? String {
            let measurement = Int(height.dropLast(2))!
            if height.contains("cm") {
                return (150...193).contains(measurement)
            } else if height.contains("in") {
                return (59...76).contains(measurement)
            }
        }
        return false
    }
    private var isValidIssueYear: Bool {
        if let issueYear = self["iyr"] as? String, let year = Int(issueYear) {
            return (2010...2020).contains(year)
        }
        return false
    }
    private var isValidPassportID: Bool {
        if let passportID = self["pid"] as? String {
            return passportID.count == 9 && passportID.range(of: "[^0-9]", options: .regularExpression) == nil
        }
        return false
    }
}

func parse() -> [PassportData] {
    let report = Bundle.main.path(forResource: "Passports", ofType: "txt")!
    let content = try! String(contentsOfFile: report)
    let components = content.components(separatedBy: "\n\n")
    let data: [PassportData] = components.map({
        var _data: PassportData = [ : ]
        let newComponents = $0.replacingOccurrences(of: "\n", with: " ").components(separatedBy: " ")
        newComponents.forEach({
            let dataComponents = $0.components(separatedBy: ":")
            _data[dataComponents[0]] = dataComponents[1]
        })
        return _data
    })
    return data
}

let data = parse()
//data.forEach({ print($0) })
let validPassports = data.filter({ $0.isValid })
print(validPassports.count)
