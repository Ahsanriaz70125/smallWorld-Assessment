//
//  ModelViewVeiwModelTests.swift
//  ModelViewVeiwModelTests
//
//  Created by Ahsan Riaz on 07/08/2023.
//

import XCTest
@testable import ModelViewVeiwModel

class ModelViewVeiwModelTests: XCTestCase {
    
    override func setUpWithError() throws {

    }

        
        func testFetchMoviesList() {
        
        let expectation = XCTestExpectation(description: "Data fetched successfully")
            
        APIManager.shared.fetchMovieList { response  in

            switch response {
                
            case .success(let movieList):

                XCTAssertNotNil(movieList)
                expectation.fulfill()
                print(movieList)

                
            case .failure(let error):
                
                XCTAssertNil(error)
                XCTFail("API call failed with error: \(error)")
                print(error)

            }
          }
            wait(for: [expectation], timeout: 5.0)
        }
    

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
