//
//  FavoriteVMTests.swift
//  GamesTests
//
//  Created by Abdurrahman Alboghdady on 01/06/2023.
//

import XCTest
@testable import Games

class FavoriteVMTests: XCTestCase {
    
    var sut: FavoriteVM!
    var mockGamesDataSource: MockGamesDataSource!
    
    override func setUp() {
        super.setUp()
        mockGamesDataSource = MockGamesDataSource()
        sut = FavoriteVM(gamesDataSource: mockGamesDataSource)
    }
    
    override func tearDown() {
        sut = nil
        mockGamesDataSource = nil
        super.tearDown()
    }
    
    func testGetGames() {
        // Mock the fetchEntities method of CoreDataHandler to return some test GameItems
        if let newGame = CoreDataHandler.shared.createEntity(GameItem.self) {
            newGame.id = 1
            newGame.name = "Game 1"
            newGame.background_image = "game.background_image"
            newGame.metacritic = 91
            CoreDataHandler.shared.saveContext()
        }
        sut.getGames()
        
        XCTAssertEqual(sut.games.last!.id, 1)
        XCTAssertEqual(sut.games.last!.name, "Game 1")
        
        XCTAssertTrue(mockGamesDataSource.setGamesCalled)
    }
    
    func testDeleteGame() {
        // Mock the fetchEntities method of CoreDataHandler to return some test GameItems
        if let newGame = CoreDataHandler.shared.createEntity(GameItem.self) {
            newGame.id = 1
            newGame.name = "Game 1"
            newGame.background_image = "game.background_image"
            newGame.metacritic = 91
            CoreDataHandler.shared.saveContext()
        }
        if let newGame = CoreDataHandler.shared.createEntity(GameItem.self) {
            newGame.id = 2
            newGame.name = "Game 2"
            newGame.background_image = "game.background_image"
            newGame.metacritic = 94
            CoreDataHandler.shared.saveContext()
        }
        sut.getGames()
        let count = sut.games.count
        sut.getGames()
        
        // Delete the game at index 0
        sut.deleteGame(at: sut.games.count - 1)
        
        XCTAssertEqual(sut.games.count, count - 1)
        XCTAssertEqual(sut.games.last!.id, 1)
        XCTAssertEqual(sut.games.last!.name, "Game 1")
        
        XCTAssertTrue(mockGamesDataSource.setGamesCalled)
    }
}

class MockCoreDataHandler {
    
    static let shared = MockCoreDataHandler()
    
    var fetchEntitiesResult: [Any]?
    var deletedEntity: Any?
    
    private init() {}
    
    func fetchEntities(ofType type: Any.Type) -> [Any]? {
        return fetchEntitiesResult
    }
    
    func deleteEntity(_ entity: Any) {
        deletedEntity = entity
    }
    
    func saveContext() {
        // Do nothing
    }
}
