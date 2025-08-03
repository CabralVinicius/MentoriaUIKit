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
        let frontDefault: URL?
        let frontShiny:  URL?
        let backDefault: URL?
        let backShiny:   URL?
        
        let other: OtherSprites?
        
        enum CodingKeys: String, CodingKey {
            case frontDefault = "front_default"
            case frontShiny   = "front_shiny"
            case backDefault  = "back_default"
            case backShiny    = "back_shiny"
            case other
        }
        
        struct OtherSprites: Codable {
            let dreamWorld: DreamWorld?
            let officialArt: OfficialArtwork?
            let home: HomeSprites?
            
            enum CodingKeys: String, CodingKey {
                case dreamWorld  = "dream_world"
                case officialArt = "official-artwork"
                case home
            }
            
            struct DreamWorld: Codable {
                let frontDefault: URL?
                let frontFemale:  URL?
                enum CodingKeys: String, CodingKey {
                    case frontDefault = "front_default"
                    case frontFemale  = "front_female"
                }
            }
            
            struct OfficialArtwork: Codable {
                let frontDefault: URL?
                enum CodingKeys: String, CodingKey {
                    case frontDefault = "front_default"
                }
            }
            
            struct HomeSprites: Codable {
                let frontDefault: URL?
                let frontShiny:   URL?
                enum CodingKeys: String, CodingKey {
                    case frontDefault = "front_default"
                    case frontShiny   = "front_shiny"
                }
            }
        }
    }
}
