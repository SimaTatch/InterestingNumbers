//
//  NetworkDataFetcher.swift
//  InterestingNumbersApp
//
//  Created by Серафима  Татченкова  on 08.05.2022.
//

import Foundation


class NetworkDataFetcher {
    
    var networkService = NetworkService()
    
    func fetchFacts(number: String, type: String, completion: @escaping (SearchResultsDateJSON?) -> ()) {
        networkService.request(number: number, type: type) { data, error in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                completion(nil)
            }
            let decode = self.decodeJSON(type: SearchResultsDateJSON.self, from: data)
            completion(decode)
//            print(decode)
        }
    }
    
    func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else {return nil}
        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
        } catch let jsonError {
            print("Failed to decode JSON", jsonError)
            return nil
        }
    }
}