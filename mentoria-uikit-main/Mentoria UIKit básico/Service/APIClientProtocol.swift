//
//  APIClientProtocol.swift
//  Mentoria UIKit básico
//
//  Created by Vinicius Cabral on 03/08/25.
//

import UIKit
import Foundation

protocol APIClientProtocol {
    func request<T: Decodable>(url: URL) async throws -> T
}

final class APIClient: APIClientProtocol {
    func request<T>(url: URL) async throws -> T where T : Decodable {
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let http = response as? HTTPURLResponse, 200..<300 ~= http.statusCode else {
            throw NetworkError.invalidStatus((response as? HTTPURLResponse)?.statusCode ?? -1)
        }
        return try JSONDecoder().decode(T.self, from: data)
    }
}

enum NetworkError: Error {
    case invalidURL
    case invalidStatus(Int)
}
