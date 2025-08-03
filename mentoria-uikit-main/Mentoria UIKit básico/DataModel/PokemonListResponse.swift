//
//  PokemonListResponse.swift
//  Mentoria UIKit básico
//
//  Created by Vinicius Cabral on 03/08/25.
//

import Foundation

struct PokemonListResponse: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [PokemonSummary]
}

struct PokemonSummary: Decodable, Identifiable{
    let name: String
    let url: URL
    
    var id: Int {
        Int(url.lastPathComponent.dropLast())!
    }
}
