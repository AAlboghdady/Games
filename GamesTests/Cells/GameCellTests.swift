//
//  GameCellTests.swift
//  GamesTests
//
//  Created by Abdurrahman Alboghdady on 01/06/2023.
//

import XCTest
@testable import Games

class GameCellTests: XCTestCase {
    
    var gameCell: GameCell!

    override func setUp() {
        super.setUp()
        gameCell = GameCell()
        // Load the GameCell from the nib file
        let nib = UINib(nibName: "GameCell", bundle: nil)
        let objects = nib.instantiate(withOwner: nil, options: nil)
        if let cell = objects.first as? GameCell {
            gameCell = cell
        }
    }

    override func tearDown() {
        gameCell = nil
        super.tearDown()
    }

    func testConfigure() {
        // Given
        var game = Game()
        game.background_image = "https://example.com/image.jpg"
        game.name = "Game Name"
        game.genres = [Genre(name: "Action"), Genre(name: "Adventure")]
        game.metacritic = 85
        game.isFavorite = true
        
        // When
        gameCell.configure(game: game)
        
        // Then
        XCTAssertEqual(gameCell.nameLabel.text, "Game Name")
        XCTAssertEqual(gameCell.genreLabel.text, "Action, Adventure")
        XCTAssertEqual(gameCell.metacriticLabel.text, "85")
        XCTAssertEqual(gameCell.favoriteButton.currentTitle, Constants.FavoritedText)
    }
    
    // Add more test cases for other methods or scenarios if needed

}
