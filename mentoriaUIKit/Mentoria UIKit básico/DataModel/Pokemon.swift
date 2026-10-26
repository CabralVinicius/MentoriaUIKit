struct Pokemon: Decodable {
    let name: String
    let number: Int
    let pokemonImage: String
}

extension Pokemon {
    static func mock() -> Pokemon {
        return Pokemon(name: "Koffing Mock", number: 109, pokemonImage: "koffing")
    }
}
