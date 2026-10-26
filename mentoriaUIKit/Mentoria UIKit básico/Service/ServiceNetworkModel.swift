//
//  ServiceNetworkModel.swift
//  Mentoria UIKit básico
//
//  Created by Vinicius Cabral on 25/01/26.
//

import Foundation
//let url = URL(string: "https://pokeapi.co/api/v2/pokemon?offset=1&limit=20")

// Modelo de exemplo
struct PokemonResponse: Decodable {
    let count: Int
    let results: [Pokemon]
}

// 1. Protocolo do Serviço (Para sua ViewModel não depender da implementação concreta)
protocol PokemonServiceProtocol {
    func getPokemons(completion: @escaping (Result<PokemonResponse, RequestError>) -> Void)
}

// 2. A Implementação do Serviço
class PokemonService: PokemonServiceProtocol {
    
    // AQUI ESTÁ A MÁGICA: Injeção de Dependência.
    // O serviço não cria o RequestOperation, ele recebe um.
    private let networkClient: NetworkClientProtocol
    private let baseURL = "https://pokeapi.co/api/v2/pokemon?offset=1&limit=20"
    
    // Init que permite injetar qualquer coisa que siga o protocolo (útil para testes)
    init(networkClient: NetworkClientProtocol = RequestOperation()) {
        self.networkClient = networkClient
    }
    
    func getPokemons(completion: @escaping (Result<PokemonResponse, RequestError>) -> Void) {
        // O compilador infere que T é 'PokemonResponse' baseado na closure do completion
        networkClient.fetchData(urlString: baseURL) { (result: Result<PokemonResponse, RequestError>) in
            switch result {
            case .success(let data):
                // Aqui você poderia fazer alguma regra de negócio extra antes de devolver
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
