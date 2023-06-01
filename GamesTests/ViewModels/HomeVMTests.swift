//
//  HomeVMTests.swift
//  GamesTests
//
//  Created by Abdurrahman Alboghdady on 01/06/2023.
//

import XCTest
@testable import Games

class HomeVMTests: XCTestCase {
    
    var sut: HomeVM!
    var mockService: MockGameRequest!
    var mockGamesDataSource: MockGamesDataSource!
    var mockLoadingDelegate: MockLoadingDelegate!
    
    override func setUp() {
        super.setUp()
        mockService = MockGameRequest()
        mockGamesDataSource = MockGamesDataSource()
        mockLoadingDelegate = MockLoadingDelegate()
        sut = HomeVM(service: mockService, gamesDataSource: mockGamesDataSource, loadingDelegate: mockLoadingDelegate)
    }
    
    override func tearDown() {
        sut = nil
//        mockService = nil
        mockGamesDataSource = nil
        mockLoadingDelegate = nil
        super.tearDown()
    }
    
    func testLoadGamesFromAPI() {
        let searchText = "test"
        let isLoadingMore = false
        
        sut.loadGamesFromAPI(searchText: searchText, isLoadingMore: isLoadingMore)
        
        XCTAssertTrue(mockLoadingDelegate.showLoadingCalled)
        XCTAssertTrue(sut.games.count == 5)
        
        // Simulate successful API response

        XCTAssertTrue(mockGamesDataSource.setGamesCalled)
    }
    
    func testSaveGame() {
        sut.loadGamesFromAPI()
        
        sut.saveGame(at: 0)
        
        XCTAssertTrue(sut.games.first!.isFavorite!)
    }
    
    func testValidateSearch() {
        let text = "test"
        
        sut.validateSearch(text: text)
        
        XCTAssertTrue(sut.games.count == 5)
    }
    
    func testCancelRequest() {
        sut.cancelRequest()
        
        XCTAssertTrue(mockService.cancelRequestCalled)
    }
        
}

//class MockGamesRequest: GamesRequest {
//
//    var getFunctionCalled = false
//    var getFunctionParameter: (function: GameAPIFunction, model: Decodable.Type)?
//    var getCompletion: ((Result<Decodable, Error>) -> Void)?
//    var cancelRequestCalled = false
//
//    func get<T>(function: GameAPIFunction, model: T.Type, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
//        getFunctionCalled = true
//        getFunctionParameter = (function, model)
//        getCompletion = { result in
//            completion(result as! Result<T, Error>)
//        }
//    }
//
//    override func cancelRequest() {
//        cancelRequestCalled = true
//    }
//}

class MockGamesDataSource: NSObject, GamesDataSource {
    
    var setGamesCalled = false
    
    func setGames() {
        setGamesCalled = true
    }
}

class MockLoadingDelegate: NSObject, LoadingDelegate {
    
    var showLoadingCalled = false
    
    func showLoading(_ isLoading: Bool) {
        showLoadingCalled = true
    }
}
