//
//  FavoriteVCTests.swift
//  GamesTests
//
//  Created by Abdurrahman Alboghdady on 01/06/2023.
//

import XCTest
@testable import Games

class FavoriteVCTests: XCTestCase {
    
    var sut: FavoriteVC!

    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "\(FavoriteVC.self)") as? FavoriteVC
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testCollectionViewDelegateIsSet() {
        XCTAssertNotNil(sut.collectionView.delegate)
        XCTAssertTrue(sut.collectionView.delegate is FavoriteVC)
    }
    
    func testCollectionViewDataSourceIsSet() {
        XCTAssertNotNil(sut.collectionView.dataSource)
        XCTAssertTrue(sut.collectionView.dataSource is FavoriteVC)
    }
    
    func testCollectionViewRegistersCell() {
        let cell = sut.collectionView.dequeueReusableCell(withReuseIdentifier: "\(GameCell.self)", for: IndexPath(item: 0, section: 0))
        XCTAssertTrue(cell is GameCell)
    }
}
