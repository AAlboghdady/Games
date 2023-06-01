//
//  FavoriteVM.swift
//  Games
//
//  Created by Abdurrahman Alboghdady on 01/06/2023.
//

import Foundation

class FavoriteVM {
    
    var games: [Game] = []
    weak private var gamesDataSource: GamesDataSource!
    
    init(gamesDataSource: GamesDataSource) {
        self.gamesDataSource = gamesDataSource
    }
    
    func getGames() {
        let newGames: [GameItem] = CoreDataHandler.shared.fetchEntities(ofType: GameItem.self)
        games = []
        for newGame in newGames {
            var game = Game()
            game.id = newGame.id
            game.name = newGame.name
            game.background_image = newGame.background_image
            game.metacritic = newGame.metacritic
            game.genres = newGame.genres as? [Genre]
            
            games.append(game)
        }
        gamesDataSource.setGames()
    }
    
    func deleteGame(at index: Int) {
        let newGames: [GameItem] = CoreDataHandler.shared.fetchEntities(ofType: GameItem.self)
        
        if let gameToDelete = newGames.first(where: { $0.id == games[index].id }) {
            CoreDataHandler.shared.deleteEntity(gameToDelete)
            CoreDataHandler.shared.saveContext()
            games.remove(at: index)
            gamesDataSource.setGames()
        }
    }
}
