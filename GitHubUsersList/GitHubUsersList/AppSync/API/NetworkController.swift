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
                DispatchQueue.main.async { resultHandler(.failure(.clientError)) }
                return
            }
            
            guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
                DispatchQueue.main.async { resultHandler(.failure(.serverError)) }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async { resultHandler(.failure(.noData)) }
                return
            }
            
            guard let decodedData: T = self.decodedData(data) else {
                DispatchQueue.main.async { resultHandler(.failure(.dataDecodingError)) }
                return
            }
            
            DispatchQueue.main.async { resultHandler(.success(decodedData)) }
        }
        
        urlTask.resume()
    }
    
    private func decodedData<T: Decodable>(_ data: Data) -> T? {
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch (let error) {
            print(error)
            return nil
        }
    }
}
