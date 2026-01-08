import Foundation
@testable import InterViewDemo

class MockURLProtocol: URLProtocol {
    static var mockResponse: HTTPURLResponse?
    static var mockData: Data?
    static var mockError: ApiError?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    
    override func startLoading() {
        if let error = MockURLProtocol.mockError {
            self.client?.urlProtocol(self, didFailWithError: error)
        }
        if let response = MockURLProtocol.mockResponse  {
            self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        }
        if let data = MockURLProtocol.mockData {
            self.client?.urlProtocol(self, didLoad: data)
        }
        self.client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() { // Required override, even if you don’t need cleanup // You can leave it empty if nothing special is needed
    }
    
}
