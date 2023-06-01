//
//  GameDetailsVMTests.swift
//  GamesTests
//
//  Created by Abdurrahman Alboghdady on 01/06/2023.
//

import XCTest
@testable import Games

final class GameDetailsVMTests: XCTestCase {
    
    var sut: GameDetailsVM!
    var mockService: MockGameRequest!
    var mockGameDataSource: MockGameDataSource!
    var mockLoadingDelegate: MockLoadingDelegate!
    
    override func setUp() {
        super.setUp()
        mockService = MockGameRequest()
        mockGameDataSource = MockGameDataSource()
        mockLoadingDelegate = MockLoadingDelegate()
        sut = GameDetailsVM(service: mockService, gameDataSource: mockGameDataSource, loadingDelegate: mockLoadingDelegate)
    }
    
    override func tearDown() {
        sut = nil
        mockService = nil
        mockGameDataSource = nil
        mockLoadingDelegate = nil
        super.tearDown()
    }
    
    func testLoadGameFromAPI() {
        sut.loadGameFromAPI(id: 3328)
        
        XCTAssertTrue(mockLoadingDelegate.showLoadingCalled)
    }
    
    func testSave() {
        var testGameDetails = GameDetails()
        testGameDetails.id = 3328
        testGameDetails.name = "The Witcher 3: Wild Hunt"
        testGameDetails.background_image = "test_image_url"
        testGameDetails.metacritic = 85
        
        sut.gameDetails = testGameDetails
        
        sut.save(game: testGameDetails)
        
        XCTAssertEqual(sut.gameDetails.isFavorite, true)
    }
    
    func testDeleteGame() {
        var testGameDetails = GameDetails()
        testGameDetails.id = 3328
        testGameDetails.name = "The Witcher 3: Wild Hunt"
        testGameDetails.background_image = "test_image_url"
        testGameDetails.metacritic = 85
        
        sut.gameDetails = testGameDetails
        
        sut.deleteGame(id: 3328)
        
        XCTAssertEqual(sut.gameDetails.isFavorite, false)
    }
    
    // Add more test cases as needed for other methods and behaviors
    
}

class MockGameDataSource: NSObject, GameDataSource {
    
    var setGamesCalled = false
    
    func set(game: GameDetails) {
        setGamesCalled = true
    }
}
