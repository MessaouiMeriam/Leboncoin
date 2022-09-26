//
//  HTTPClientProtocol.swift
//  leboncoin
//
//  Created by Messaoui Meriam on 20/09/2022.
//

import Foundation

protocol HTTPClientProtocol {
    func getList<T: Decodable>(api: HTTPApi, completion: @escaping (Result<[T], NetworkError>) -> Void)
}
enum NetworkError: Error  {
    case badUrl
    case invalidData
    
    var description: String {
        switch self {
        case .badUrl:
            return "BadURLError"
        case .invalidData:
            return "InvalidDataError"
        }
    }
    
}
class HTTPClient: HTTPClientProtocol {

    private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol) {
        self.session = session
    }
    
    // MARK:- Public Methods
    func get(url: URL, completion: @escaping (Data?, URLResponse?, NetworkError?) -> Void) {
        
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request) {(data, response, error) in
            DispatchQueue.main.async {
                
                guard let data = data else {
                    completion(nil, response, .invalidData)
                    return
                }
                completion(data, response, nil)
            }
        }
        task.resume()

    }

    func getList<T: Decodable>(api: HTTPApi, completion: @escaping (Result<[T], NetworkError>) -> Void) {
        
        guard let url = URL(string: HTTPApi.baseUrl + api.path) else {
            DispatchQueue.main.async {
                completion(.failure(.badUrl))
            }
            return
        }
        
        get(url: url) { (data, _, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                let list = try? JSONDecoder().decode([T].self, from: data ?? Data())
                completion(.success(list ?? []))
            }
        }
    }
}
