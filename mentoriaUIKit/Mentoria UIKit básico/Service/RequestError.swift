//
//  RequestError.swift
//  Mentoria UIKit básico
//
//  Created by Vinicius Cabral on 25/01/26.
//

enum RequestError: Error{
    case invalidURL
    case network(Error?)
    case invalidResponse
    case noData
    case decodingError(Error)
}
