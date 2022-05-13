
import XCTest
@testable import InterestingNumbersApp

class InterestingNumbersAppTests: XCTestCase {
    
    private let service = NetworkDataFetcher()
    
    
    func testErrorJSON() {
        let data = "Just a plain error".data(using: String.Encoding.utf8)!
        guard case .Error = service.decodeJSON(type: SearchResultsDateJSON.self, from: data) else {
            XCTFail("Couldn't recognize malformed JSON response")
            return
        }
    }
    
    func testSuccessJSON() {
        let data =  " { \"text\": \"231 is the number of cubic inches in a U.S. liquid gallon.\", \"number\": 231, \"found\": true, \"type\": \"trivia\" }".data(using: String.Encoding.utf8)!
        guard case let .Success(conditions) = service.decodeJSON(type: SearchResultsDateJSON.self, from: data) else {
            return
        }
        XCTAssertEqual("231 is the number of cubic inches in a U.S. liquid gallon.", conditions.text )
        XCTAssertEqual(nil, conditions.year)
        XCTAssertEqual(231, conditions.number)
        XCTAssertEqual(true, conditions.found)
        XCTAssertEqual("trivia", conditions.type)
    }
    
    func testParseJsonWithoutExpectedValues() {
        let data = "{ \"foo\": 42.0, \"main\": \"hello\" }".data(using: String.Encoding.utf8)!
        guard case .Error = service.decodeJSON(type: SearchResultsDateJSON.self, from: data) else {
            XCTFail("Couldn't recognize malformed JSON response")
            return
        }
    }
    
    
    
}
