//
//  GiphySearchTests.swift
//  GiphySearchTests
//
//  Created by Noel Achkar on 21/11/2020.
//

import XCTest
@testable import GiphySearch

class GiphySearchTests: XCTestCase {

    let model = ImagesModel()
    let favModel = FavoritesModel()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testTrendingRequest() {
        let testExp = XCTestExpectation(description: "Trending Request")

        model.getTrendings(completionHandler: { success,message,result in
            XCTAssertEqual(success, true)
            XCTAssertEqual(message, "OK")

            testExp.fulfill()
        })

        wait(for: [testExp], timeout: 5.0)
    }
    
    func testSearchRequest() {
        let testExp = XCTestExpectation(description: "Search Request")

        model.searchImages(text: "cars", completionHandler: { success,message,result in
            XCTAssertEqual(success, true)
            XCTAssertEqual(message, "OK")
            
            testExp.fulfill()
        })

        wait(for: [testExp], timeout: 5.0)
    }
    
    func testFavorite() {
        //Initialy not favorite
        XCTAssertFalse(ImagesCellViewModelItem.getImage().isFavorite)
        
        //Set favorite
        model.updateImageState(image: ImagesCellViewModelItem.getImage())
        //Should return true
        XCTAssertTrue(model.getIsFavorite(imageId: ImagesCellViewModelItem.getImage().imageId))
        
        //Remove favorite
        favModel.removeImageFavorite(imageId: ImagesCellViewModelItem.getImage().imageId)
        //Shoule return false
        XCTAssertFalse(model.getIsFavorite(imageId: ImagesCellViewModelItem.getImage().imageId))
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

internal extension ImagesCellViewModelItem {
    static func getImage() -> ImagesCellViewModelItem {
        return ImagesCellViewModelItem.init(imageId: "123123123123", imageUrl: "https://media1.giphy.com/media/O58wTsoBqBqMw/100w.gif?cid=32fc00426xucx4co6s8p2xi60y5f5356bn5c3zlm99fyja8u&rid=100w.gif", imageTitle: "Test", imageRating: "pg", imageSource: "test.com", isFavorite: false)
    }
}


