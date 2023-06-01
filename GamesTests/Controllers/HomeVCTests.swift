//
//  HomeVCTests.swift
//  GamesTests
//
//  Created by Abdurrahman Alboghdady on 01/06/2023.
//

import XCTest
@testable import Games

class HomeVCTests: XCTestCase {
    
    var sut: HomeVC!

    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "\(HomeVC.self)") as? HomeVC
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testCollectionViewDelegateIsSet() {
        XCTAssertNotNil(sut.collectionView.delegate)
        XCTAssertTrue(sut.collectionView.delegate is HomeVC)
    }
    
    func testCollectionViewDataSourceIsSet() {
        XCTAssertNotNil(sut.collectionView.dataSource)
        XCTAssertTrue(sut.collectionView.dataSource is HomeVC)
    }
    
    func testCollectionViewRegistersCell() {
        let cell = sut.collectionView.dequeueReusableCell(withReuseIdentifier: "\(GameCell.self)", for: IndexPath(item: 0, section: 0))
        XCTAssertTrue(cell is GameCell)
    }
    
    func testTextFieldDidChange() {
        sut.searchTF.text = "test"
        sut.textFieldDidChange(sut.searchTF)
        // Assert the appropriate actions were performed or check the expected behavior
    }
    
    func testSearchRepositories() {
        sut.searchRepositories()
        // Assert the appropriate actions were performed or check the expected behavior
    }
    
    // Add more test cases as needed for other methods and behaviors
    
}
