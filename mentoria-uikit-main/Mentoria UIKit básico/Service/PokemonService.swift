//
//  PokemonService.swift
//  Mentoria UIKit básico
//
//  Created by Guilerme Barciki on 14/05/25.
//
import UIKit

final class PokemonService{
    private let client: APIClientProtocol
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")!
    
    init(client: APIClientProtocol = APIClient()) {
        self.client = client
    }
    
    func fetchFirst150summaries() async throws -> [PokemonSummary] {
        var comps = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)!
        comps.queryItems = [
            URLQueryItem(name: "offset", value: "0"),
            URLQueryItem(name: "limit", value: "150")
        ]
        guard let url = comps.url else {
            throw NetworkError.invalidURL
        }
        let response: PokemonListResponse = try await client.request(url: url)
        return response.results
    }
    
    func fetchDetail(for summary: PokemonSummary) async throws -> PokemonDetail {
        try await client.request(url: summary.url)
    }
    
    func fetchFirst150Details() async throws -> [PokemonDetail] {
        let summaries = try await fetchFirst150summaries()
        return try await withThrowingTaskGroup(of: PokemonDetail.self) { group in
            var details: [PokemonDetail] = []
            
            for summary in summaries {
                group.addTask{
                    try await self.fetchDetail(for: summary)
                }
            }
            
            for try await detail in group {
                details.append(detail)
            }
            
            return details.sorted{ $0.id < $1.id }
        }
    }
}
