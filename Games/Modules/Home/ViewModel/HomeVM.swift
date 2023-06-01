//
//  HomeVM.swift
//  Games
//
//  Created by Abdurrahman Alboghdady on 28/05/2023.
//

import Foundation

class HomeVM {
    
    var games: [Game] = []
    var error: String = ""
    
    private var service: Service!
    weak private var gamesDataSource: GamesDataSource!
    weak private var loadingDelegate: LoadingDelegate!
    // task for cancelling request if needed
    private var task: URLSessionTask!
    private var page = 1
    private var searchTextCount = 0
    
    init(service: Service) {
        self.service = service
    }
    
    init(service: Service, gamesDataSource: GamesDataSource, loadingDelegate: LoadingDelegate) {
        self.service = service
        self.gamesDataSource = gamesDataSource
        self.loadingDelegate = loadingDelegate
    }
    
    func loadGamesFromAPI(searchText: String? = nil, isLoadingMore: Bool = false) {
        loadingDelegate.showLoading(true)
        if isLoadingMore {
            page += 1
        }
        service.get(function: .games(searchText: searchText, page: page), model: GameList.self) { [weak self] result in
            guard let self = self else { return }
            self.loadingDelegate.showLoading(false)
            switch result {
            case .success(let data):
                self.games.append(contentsOf: data.results ?? [])
                self.gamesDataSource.setGames()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func saveGame(at index: Int) {
        let game = games[index]
        if let newGame = CoreDataHandler.shared.createEntity(GameItem.self) {
            newGame.id = game.id ?? 0
            newGame.name = game.name
            newGame.background_image = game.background_image
            newGame.metacritic = game.metacritic ?? 0
            newGame.genres = game.genres as? NSObject
            // Saving the context
            CoreDataHandler.shared.saveContext()
        }
        games[index].isFavorite = true
    }
    
    func validateSearch(text: String) {
        let text = text.filter { $0 != Character(" ") }
        let count = text.count
        if count == 0 {
            // get the default games list
            searchTextCount = count
            reloadGames()
        } else if searchTextCount > 3 && count <= 3 {
            // filter with text less than 4 char when user is deleting from the previous search
            reloadGames(text: text)
        } else if count > 3 {
            // add validation to tsearch after the fourth Character is typed
            print(text)
            searchTextCount = count
            reloadGames(text: text)
        }
    }
    
    func reloadGames(text: String? = nil) {
        page = 1
        games.removeAll()
        gamesDataSource.setGames()
        loadGamesFromAPI(searchText: text)
    }
    
    func cancelRequest() {
        service.cancelRequest()
    }
}

protocol LoadingDelegate: NSObject {
    func showLoading(_ isLoading: Bool)
}

protocol GamesDataSource: NSObject {
    func setGames()
}
