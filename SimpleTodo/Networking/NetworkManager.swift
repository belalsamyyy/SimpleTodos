//
//  NetworkManager.swift
//  SimpleTodo
//
//  Created by Belal Samy on 10/26/24.
//

import UIKit

typealias Params = [String: Any]

//MARK: - Network Manager

class NetworkManager {
    static let shared = NetworkManager()
    
    var baseURL: String {
        guard let url = Bundle.main.object(forInfoDictionaryKey: "BaseURL") as? String else { return "" }
        return url
    }
     
    func baseNetworkCall<T: Codable>(for params: Params, headerType: HeaderType = .json, body: Data? = nil, endPoint: String, type: BaseModel<T>.Type, method: HTTPMethod, completed: @escaping (Result<BaseModel<T>, STError>) -> Void) {
        // url
        let innerEndpoint = baseURL + endPoint
        guard let encodedJSONString = innerEndpoint.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: encodedJSONString) else {
            completed(.failure(.invalidURL))
            return
        }
         
        // params
        var parameters: Params = [:]
        parameters += params
         
        // headers
        var request = URLRequest(url: url, timeoutInterval: 30)
        request.setValue(headerType.contentType, forHTTPHeaderField: "Content-Type")
         
        // http method
        request.httpMethod = method.rawValue
         
        // body
        let paramBody = parameters.percentEncoded()
        request.httpBody = body ?? paramBody
         
        // request logger
        request.logRequest(params)
        
        // data task
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // response logger
            (response as? HTTPURLResponse)?.logResponse(data)
            
            // check errors
            if let error = error {
                completed(.failure(.checkInternetConnection))
                print("error description: \(error.localizedDescription)")
                return
            }
           
            // check valid response & status codes range
            guard let response = response as? HTTPURLResponse, (200...430) ~= response.statusCode else {
                completed(.failure(.invalidResponse))
               return
            }
             
            // check data
            guard let data else {
                completed(.failure(.invalidData))
                return
            }
             
            do {
                // decoding json -> model
                let result = try JSONDecoder().decode(type, from: data)
                DispatchQueue.main.async {
                    if 200...202 ~= response.statusCode {
                        completed(.success(result))
                    } else {
                        completed(.failure(.customValue("error: something went wrong")))
                    }
                }
                
            } catch let error as NSError {
                completed(.failure(.failedDecoding))
                print("error description: \(error.localizedDescription)")
            }
        }
        
        // resume task
        task.resume()
    }
}
