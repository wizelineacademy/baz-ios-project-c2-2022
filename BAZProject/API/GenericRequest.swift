//
//  GenericRequest.swift
//  BAZProject
//
//  Created by Fredy Dominguez on 10/11/22.
//

import Foundation

protocol GenericRequestProtocol {
    var apiKey: String { get }
    var urlBase: String { get }
    
    func decodeInfo<T:Decodable>(with data: Data, decoder: JSONDecoder) -> T?
    func getFetch<T: Decodable>(with request: URLRequest, completion: @escaping (Result<T, Error>) -> Void)
}

extension GenericRequestProtocol {
    
    var apiKey: String  {
        return "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    }
    var urlBase: String {
        return "https://api.themoviedb.org/3"
    }
    
    /// Decode info type data to a Movie model
    /// - Parameters:
    ///    - data: Info received in type Data.
    ///    - decoder:Custom JsonDecoder
    func decodeInfo<T:Decodable>(with data: Data, decoder: JSONDecoder = JSONDecoder()) -> T? {
        do {
            let decoded = try decoder.decode(T.self, from: data)
            return decoded
        } catch let error as NSError{
            debugPrint("Error parsing: \(error.debugDescription)")
            return nil
        }
    }
    
    
    /// URLSession request
    ///  - Parameter request: request to API
    ///  - Returns: Result custorm type and Error if this appear
    func getFetch<T: Decodable>(with request: URLRequest, completion: @escaping (Result<T, Error>) -> Void) {
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, let result: T = self.decodeInfo(with: data) else {
                completion(Result.failure(APIError.decodeError))
                return
            }
            completion(Result.success(result))
        }.resume()
    }
}
