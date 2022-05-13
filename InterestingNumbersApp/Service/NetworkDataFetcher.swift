

import Foundation


class NetworkDataFetcher {
    
    var networkService = NetworkService()
    
    //MARK: - fetch для чисел и дат
    func fetchFacts(number: String, type: String, completion: @escaping (SearchResult?) -> ()) {
        networkService.request(number: number, type: type) { data, error in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                completion(nil)
            }
            let decode = self.decodeJSON(type: SearchResultsDateJSON.self, from: data)
            DispatchQueue.main.async {
                completion(decode)
            }
            print(decode)
        }
    }
    
    //MARK: - fetch для диапазонов и пар чисел
    func fetchRange(number: String, type: String, completion: @escaping ([String: String]?) -> ()) {
        networkService.request(number: number, type: type) { data, error in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                completion(nil)
            }
//            let decode = self.decodeJSON(type: SearchResultsRangeJSON.self, from: data)
            let raw = try? JSONSerialization.jsonObject(with: data ?? Data(), options: [])
             let json = raw as? [String: String]
            completion(json)
//            print(decode)
        }
    }
    
    func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> SearchResult? {
        let decoder = JSONDecoder()
        guard let data = from else {return nil}
        do {
            let objects = try decoder.decode(type.self, from: data)
            return .Success(objects as! SearchResultsDateJSON)
        } catch let jsonError {
            print("Failed to decode JSON", jsonError)
            return .Error("Malformed JSON response")
        }
    }
    
    func decodeResult(fromJsonData data: Data) -> SearchResult {
        let raw = try? JSONSerialization.jsonObject(with: data, options: [])
        guard let json = raw as? [String: AnyObject],

              let text = json["text"] as? String,
              let year = json["year"] as? Int,
              let number = json["number"] as? Int,
              let found = json["found"] as? Bool,
              let type = json["type"] as? String
        else {
            return .Error("Malformed JSON response")
        }
        return .Success(SearchResultsDateJSON(text: text, year: year, number: number, found: found, type: type))
    }
}
