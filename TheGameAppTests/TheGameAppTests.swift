//
//  TheGameAppTests.swift
//  TheGameAppTests
//
//  Created by Anton Veldanov on 11/30/21.
//

import XCTest
@testable import TheGameApp

class TheGameAppTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    

    func testAPICaller_WhenValidInputProvided_ShouldReturnTrue(){

        let urlString = Constants.urlString
        let sut = APICaller()
        let expectation = expectation(description: "waiting on API Caller - URLSession")
        sut.fetchData(URL(string: urlString)!) { result in
            switch result{
            case .success(let items):
                XCTAssertEqual(4, items.count)
                expectation.fulfill()
            case .failure(_):
                break
            }
        }

        self.wait(for: [expectation], timeout: 5)
    }


    
    
    func testAPICaller_WhenValidMockInputProvided_ShouldReturnTrue(){
        
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLSession.self]
        let urlSession = URLSession(configuration: config)
        let response = "1 \n 2 \n 3 \n 4"
        MockURLSession.stubMockData = response.data(using: .utf8)

        let urlString = Constants.urlString
        let sut = APICaller(urlSession: urlSession)
        
        let expectation = expectation(description: "waiting on API Caller - URLSession")
        sut.fetchData(URL(string: urlString)!) { result in
            
            switch result{
            case .success(let items):
                XCTAssertEqual([1,2,3,4], items)
                expectation.fulfill()
            case .failure(_):
                break
            }
        }
        self.wait(for: [expectation], timeout: 5)
    }
}
