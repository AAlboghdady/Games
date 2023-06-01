//
//  GameDetailsVM.swift
//  Games
//
//  Created by Abdurrahman Alboghdady on 01/06/2023.
//

import Foundation

class GameDetailsVM {
    
    var error: String = ""
    
    var gameDetails: GameDetails!
    private var service: Service!
    weak private var gameDataSource: GameDataSource!
    weak private var loadingDelegate: LoadingDelegate!
    private var page = 1
    private var searchTextCount = 0
    
    init(service: Service) {
        self.service = service
    }
    
    init(service: Service, gameDataSource: GameDataSource, loadingDelegate: LoadingDelegate) {
        self.service = service
        self.gameDataSource = gameDataSource
        self.loadingDelegate = loadingDelegate
    }
    
    func loadGameFromAPI(id: Int64) {
        loadingDelegate.showLoading(true)
        service.get(function: .gameDetails(id: id), model: GameDetails.self) { [weak self] result in
            guard let self = self else { return }
            self.loadingDelegate.showLoading(false)
            switch result {
            case .success(let data):
                self.gameDataSource.set(game: data)
                self.gameDetails = data
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func save(game: GameDetails) {
//        _ = CoreDataHandler.shared.createEntity(game)
        if let newGame = CoreDataHandler.shared.createEntity(GameItem.self) {
            newGame.id = game.id ?? 0
            newGame.name = game.name
            newGame.background_image = game.background_image
            newGame.metacritic = game.metacritic ?? 0
            newGame.genres = game.genres as? NSObject

            // Saving the context
            CoreDataHandler.shared.saveContext()
        }
        gameDetails.isFavorite = true
    }
    
    func deleteGame(id: Int64) {
        let newGames: [GameItem] = CoreDataHandler.shared.fetchEntities(ofType: GameItem.self)
        
        if let gameToDelete = newGames.first(where: { $0.id == id }) {
            CoreDataHandler.shared.deleteEntity(gameToDelete)
            CoreDataHandler.shared.saveContext()
        }
        gameDetails.isFavorite = false
    }
    
    func cancelRequest() {
        service.cancelRequest()
    }
}

protocol GameDataSource: NSObject {
    func set(game: GameDetails)
}
