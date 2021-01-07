//
//  NetworkController.swift
//  GitHubUsersList
//
//  Created by Edgar Sia on 1/7/21.
//

import Foundation

class NetworkController {
    
    public enum NetworkControllerError: Error {
        case clientError
        case serverError
        case noData
        case dataDecodingError
    }
    
    public func dataTask<T: Decodable>(with request: URLRequest, resultHandler: @escaping (Result<T, NetworkControllerError>) -> Void) {
        let urlTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                resultHandler(.failure(.clientError))
                return
            }
            
            guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
                resultHandler(.failure(.serverError))
                return
            }
            
            guard let data = data else {
                resultHandler(.failure(.noData))
                return
            }
            
            guard let decodedData: T = self.decodedData(data) else {
                resultHandler(.failure(.dataDecodingError))
                return
            }
            
            resultHandler(.success(decodedData))
        }
        
        urlTask.resume()
    }
    
    private func decodedData<T: Decodable>(_ data: Data) -> T? {
        return try? JSONDecoder().decode(T.self, from: data)
    }
}
