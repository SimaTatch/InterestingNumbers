
import Foundation

struct SearchResults: Decodable {
    let resultString: String
}

struct SearchResultsDateJSON: Decodable {
    let text: String?
    let number: Int?
    let found: Bool?
    let type: String?
    let rangeResult: [String: String]?
}





