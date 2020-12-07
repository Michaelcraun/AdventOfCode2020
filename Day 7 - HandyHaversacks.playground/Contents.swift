import UIKit

class Haversack {
    var color: String
    var count: Int
    var contents: [Haversack]
    
    init(color: String) {
        self.color = color
        self.count = 1
        self.contents = []
    }
    
    init(text: String) {
        let components = text.components(separatedBy: " bags contain ")
        let contentComponents = components[1].components(separatedBy: ", ")
        
        self.color = components[0]
        self.count = 1
        self.contents = contentComponents.compactMap({ Haversack(subtext: $0) })
    }
    
    init?(subtext: String) {
        if subtext.contains("no other") {
            return nil
        } else {
            var mutableText = subtext
            let count = String(mutableText.removeFirst())
            mutableText.removeFirst()
            mutableText = mutableText.replacingOccurrences(of: " bags.", with: "")
            mutableText = mutableText.replacingOccurrences(of: " bags", with: "")
            mutableText = mutableText.replacingOccurrences(of: " bag", with: "")
            
            self.count = Int(count)!
            self.color = mutableText
            self.contents = []
        }
    }
    
    func canContain(bag: Haversack) -> Bool {
        if contents.contains(bag) {
            return true
        }
//        else {
            for haversack in contents {
//                if let container = data.container(for: haversack.color) {
//            let containers = contents.compactMap({ data.container(for: $0.color) })
//            for container in containers {
                if haversack.canContain(bag: bag) {
                    return true
                }
                }
//            }
//        }
        return false
    }
}

extension Haversack: Equatable {
    static func == (lhs: Haversack, rhs: Haversack) -> Bool {
        return lhs.color == rhs.color
    }
}

extension Array where Element == Haversack {
    func container(for bagColor: String) -> Haversack? {
        if let existing = self.first(where: { $0.color == bagColor }), existing.contents != [] {
            return existing
        }
        return nil
    }
}

func parse() -> [Haversack] {
    let report = Bundle.main.path(forResource: "Baggage", ofType: "txt")!
    let content = try! String(contentsOfFile: report)
    let components = content.components(separatedBy: "\n")
    return components.map({ Haversack(text: $0) })
}

func update() {
    for haversack in data {
        haversack.contents = haversack.contents.map({
            if let existing = data.container(for: $0.color) {
                return existing
            } else {
                return Haversack(color: $0.color)
            }
        })
    }
}

var contentCount: Int = 0
var data = parse()
update()
//data.forEach({ print("\($0.count) \($0.color) bag can contain \($0.contents.map({ "\($0.count) \($0.color)"})) bags.")})
let goldBagContainers = data.filter({ $0.canContain(bag: Haversack(color: "shiny gold")) })
print(goldBagContainers.count)
