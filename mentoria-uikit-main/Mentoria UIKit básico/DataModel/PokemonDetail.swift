import Foundation
import UIKit

struct PokemonDetail: Codable, Identifiable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let types: [TypeEntry]
    let sprites: Sprite
    
    struct TypeEntry: Codable {
        let slot: Int
        let type: NamedResource
    }
    
    struct NamedResource: Codable{
        let name: String
        let url: URL
    }
    
    struct Sprite: Codable {
        let front_default: URL?
    }
}
