//
//  ApiManager.swift
//  Games
//
//  Created by Abdurrahman Alboghdady on 01/06/2023.
//

import Moya
import Foundation

let ApiProvider = MoyaProvider<ApiManager>()

enum ApiManager {
    case games(searchText: String?, page: Int)
    case gameDetails(id: Int64)
}

// MARK: - TargetType Protocol Implementation
extension ApiManager: TargetType {
    var baseURL: URL {
        return URL(string: Constants.APIURL)!
    }
    
    var path: String {
        switch self {
        case .games:
            return "games"
        case .gameDetails(let id):
            return "games/\(id)"
        }
        
    }
    
    var method: Moya.Method {
        switch self {
        case .games, .gameDetails:
            return .get
        }
    }
    
    var parameters: [String: Any]? {
        var params = [String : Any]()
        switch self {
        case .games(let searchText, let page):
            if searchText != nil {
                params["search"] = searchText
            }
            params["page"] = page
            params["page_size"] = Constants.itemsPerPage
        case .gameDetails:
            break
        }
        params["key"] = Constants.APIKey
        return params
    }
    
    var parameterEncoding: Moya.ParameterEncoding {
        return JSONEncoding.default
    }
    
    var task: Task {
        switch self {
        case .games, .gameDetails:
            return .requestParameters(parameters: parameters ?? [:], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String: String]? {
        return [:]
    }
    
    var sampleData: Data {
        return Data()
    }
}
