//
//  PokemonService.swift
//  Mentoria UIKit básico
//
//  Created by Guilerme Barciki on 14/05/25.
//

import Foundation

protocol NetworkClientProtocol {
    func fetchData<T: Decodable>(urlString: String, completion: @escaping (Result<T, RequestError>) -> Void)
}

final class RequestOperation: NetworkClientProtocol {
    
    func fetchData<T: Decodable>(
        urlString: String,
        completion: @escaping (Result<T, RequestError>) -> Void) {
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                DispatchQueue.main.async { completion(.failure(.network(error))) }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                DispatchQueue.main.async { completion(.failure(.invalidResponse)) }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async { completion(.failure(.noData)) }
                return
            }
            
            do {
                let decodedObject = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decodedObject))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
        task.resume()
    }
}
