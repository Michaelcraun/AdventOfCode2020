import UIKit

func parse() -> [String] {
    let terrain = Bundle.main.path(forResource: "Terrain", ofType: "txt")!
    let content = try! String(contentsOfFile: terrain)
    return content.components(separatedBy: "\n")
}

func wouldHitTree(in biome: String, index: Int) -> Bool {
    if index >= biome.count {
        return wouldHitTree(in: biome + biome, index: index)
    } else {
        let characterIndex = biome.index(biome.startIndex, offsetBy: index)
        return biome[characterIndex] == "#"
    }
}

func path(xSlope: Int, ySlope: Int) -> Int {
    var treesHit: Int = 0
    var xIndex: Int = 0
    var yIndex: Int = 0
    
    for _ in 0..<terrain.count {
        if yIndex <= terrain.count - 1 {
            treesHit += wouldHitTree(in: terrain[yIndex], index: xIndex) ? 1 : 0
            xIndex += xSlope
            yIndex += ySlope
        }
    }
    return treesHit
}

let terrain = parse()
let treesHitOnSlopeOfOne_One = path(xSlope: 1, ySlope: 1)
let treesHitOnSlopeOfThree_One = path(xSlope: 3, ySlope: 1)
let treesHitOnSlopeOfFive_One = path(xSlope: 5, ySlope: 1)
let treesHitOnSlopeOfSeven_One = path(xSlope: 7, ySlope: 1)
let treesHitOnSlopeOfOne_Two = path(xSlope: 1, ySlope: 2)
let product = treesHitOnSlopeOfOne_Two * treesHitOnSlopeOfOne_One * treesHitOnSlopeOfFive_One * treesHitOnSlopeOfSeven_One * treesHitOnSlopeOfThree_One
print(product)
