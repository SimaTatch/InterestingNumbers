
import Foundation

//MARK: - Cтруктура для чисел и дат
struct SearchResultsDateJSON: Decodable {
    let text: String
    let year: Int?
    let number: Int?
    let found: Bool?
    let type: String?
//    let rangeResult: [String: String]?
  
}

enum SearchResult {
    case Success(SearchResultsDateJSON)
    case Error(String)
}



//работа идет между 3 файлами (этот, NetworkDataFetcher(func fetchRange) и FactViewController (строчка 57))

// MARK: - Структура для диапазонов, попытка 1, выдает рандомную пару число-факт из диапазона а не весь диапазон

//struct SearchResultsRangeJSON: Decodable {
//    typealias DestinationNumber = String
//
//    let number : DestinationNumber
//    let value : String
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        let dict = try container.decode([String:String].self)
//        guard let key = dict.keys.first else {
//            throw NSError(domain: "Decoder", code: 0, userInfo: [:])
//        }
//        number = key
//        value = dict[key] ?? ""
//    }
//}

// MARK: - попытка 2, ничего не выдает  (вставить в NetworkDataFetcher в FetchRange название этой структуры )

//struct DecodedArray: Decodable {
//    var array: [NumberFacts2]
//
//
//      // Define DynamicCodingKeys type needed for creating
//      // decoding container from JSONDecoder
//      private struct DynamicCodingKeys: CodingKey {
//
//          // Use for string-keyed dictionary
//          var stringValue: String
//          init?(stringValue: String) {
//              self.stringValue = stringValue
//          }
//
//          // Use for integer-keyed dictionary
//          var intValue: Int?
//          init?(intValue: Int) {
//              // We are not using this, thus just return nil
//              return nil
//          }
//      }
//
//    init(from decoder: Decoder) throws {
//
//            // 1
//            // Create a decoding container using DynamicCodingKeys
//            // The container will contain all the JSON first level key
//            let container = try decoder.container(keyedBy: DynamicCodingKeys.self)
//
//            var tempArray = [NumberFacts2]()
//
//            // 2
//            // Loop through each key (student ID) in container
//            for key in container.allKeys {
//
//                // Decode Student using key & keep decoded Student object in tempArray
//                let decodedObject = try container.decode(NumberFacts2.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
//                tempArray.append(decodedObject)
//            }
//
//            // 3
//            // Finish decoding all Student objects. Thus assign tempArray to array.
//            array = tempArray
//        }
//    }
//
//
//
//struct NumberFacts2: Decodable {
//
//    let myNumber: String
////    let lastName: String
//
//    // 1
//    // Define student ID
//    let myFact: String
//
//    // 2
//    // Define coding key for decoding use
//    enum CodingKeys: CodingKey {
//        case firstName
////        case lastName
//    }
//
//    init(from decoder: Decoder) throws {
//
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//
//        // 3
//        // Decode firstName & lastName
//        myNumber = try container.decode(String.self, forKey: CodingKeys.firstName)
////        lastName = try container.decode(String.self, forKey: CodingKeys.lastName)
//
//        // 4
//        // Extract studentId from coding path
//        myFact = container.codingPath.first!.stringValue
//    }
//}
