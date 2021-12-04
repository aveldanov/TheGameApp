//
//  MockURLSession.swift
//  TheGameAppTests
//
//  Created by Anton Veldanov on 12/4/21.
//

import Foundation


class MockURLSession: URLProtocol{
    
    static var stubMockData: Data?
    
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    
    override func startLoading() {
        client?.urlProtocol(self, didLoad: MockURLSession.stubMockData ?? Data())
        client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {
        
    }
    
    
}
