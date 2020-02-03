//
//  HTTPClient.swift
//  PersonalContacts
//
//  Created by jeevan tiwari on 16/01/20.
//  Copyright © 2020 jeevan tiwari. All rights reserved.
//
import Foundation

typealias CompletionResult<T: Codable> = (Result<T?, NetworkError>) -> Void

class HTTPClient {
    // MARK: Typealias
    
    
    // MARK: - Shared Instance
    static let shared = HTTPClient(session: URLSession.shared)
    
    // MARK: - Private Properties
    private let session: URLSessionProtocol
    private var task: URLSessionDataTaskProtocol?
    
    // MARK: - Initialiser
    init(session: URLSessionProtocol) {
        self.session = session
    }
    
    // MARK: - Data Task Helper
    func dataTask<T: Codable>(_ request: RequestProtocol, completion: @escaping CompletionResult<T>){
        var urlRequest = URLRequest(url: request.baseURL.appendingPathComponent(request.path),
                                    cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                    timeoutInterval: Constants.timeOut)
        urlRequest.httpMethod = request.httpMethod.rawValue
        urlRequest.httpBody = request.httpBody
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        task = session.dataTask(with: urlRequest) { (data, response, error) in
            //return error if there is any error in making request
            if let error = error {
                
                DispatchQueue.main.async {
                    completion(.failure(NetworkError(error.localizedDescription)))
                }
                
                return
            }
            //check response
            if let response = response, response.isSuccess {
                do{
                    let snakeCaseJsonDecoder = JSONDecoder()
                    snakeCaseJsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                    Log.debug(String(data: data ?? Data(), encoding: .utf8) ?? "")
                    let decodedResponse = try snakeCaseJsonDecoder.decode(T.self, from: data ?? Data())
                    DispatchQueue.main.async {
                        completion(.success(decodedResponse))
                    }
                }catch let error{
                    
                    Log.debug(error.localizedDescription)
                    DispatchQueue.main.async {
                        completion(.failure(NetworkError(Errors.JSONDecodingError.rawValue)))
                    }
                    
                }
            } else {
                DispatchQueue.main.async {
                    completion(.failure(NetworkError(Errors.JSONDecodingError.rawValue)))
                }
                
            }
        }
        
        //Resume task
        self.task?.resume()
    }
    
    func cancel() {
        self.task?.cancel()
    }
    
}
