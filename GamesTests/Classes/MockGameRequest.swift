//
//  MockGameRequest.swift
//  GamesTests
//
//  Created by Abdurrahman Alboghdady on 01/06/2023.
//

import Foundation
@testable import Games

class MockGameRequest: Service {
    
    var shouldFail = false
    var isSearching = false
    var cancelRequestCalled = false
    
    func get<T: Codable>(function: ApiManager, model: T.Type, result: @escaping(Result<T, Error>)->()) {
        if shouldFail {
            result(.failure(NSError(domain: "Error", code: 0, userInfo: nil)))
            return
        }
        if model is GameList.Type {
            var gameList = GameList()
            let games = Array(repeating: Game(), count: 5)
            gameList.results = games
            result(.success(gameList as! T))
        } else if model is GameDetails.Type {
            result(.success(GameDetails() as! T))
        }
    }
    
    func cancelRequest() {
        cancelRequestCalled = true
    }
}
