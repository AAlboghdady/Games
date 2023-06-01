//
//  GamesRequest.swift
//  Games
//
//  Created by Abdurrahman Alboghdady on 28/05/2023.
//

import Foundation
import Moya

class GamesRequest: Service {
    
    var cancellable: Cancellable!
    
    func checkConnection() -> Bool {
        switch Reachability().connectionStatus() {
        case .unknown, .offline:
            return false
        case .online(_):
            return true
        }
    }
    
    func get<T: Codable>(function: ApiManager, model: T.Type, result: @escaping(Result<T, Error>)->()) {
        if !checkConnection() {
            result(.failure(NSError(domain: "No internet connection", code: 100, userInfo: nil)))
        }
        cancellable = ApiProvider.request(function) { (moyaResult) in
            switch moyaResult {
            case .success(let value):
                do {
                    let response = try JSONDecoder().decode(T.self, from: value.data)
                    result(.success(response))
                } catch {
                    result(.failure(NSError(domain: "Can't parse response", code: 100, userInfo: nil)))
                }
            case .failure(let error):
                result(.failure(error))
            }
        }
    }
    
    func cancelRequest() {
        cancellable.cancel()
    }
}
