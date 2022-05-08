//
//  NetworkService.swift
//  InterestingNumbersApp
//
//  Created by Серафима  Татченкова  on 08.05.2022.
//

import Foundation

class NetworkService {
    
    func request(number: String, type: String, completion: @escaping (Data?, Error?) -> Void ) {
        let url = URL(string: "http://numbersapi.com/\(number)/\(type)?json")!
        let request = URLRequest(url: url)
//        request.httpMethod = "GET"
        let task = self.createDataTask(from: request, completion: completion)
        task.resume()
    }

    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                completion(data,error)
            }
        }
    }
}




//
//func request(searchTerm: String, completion: @escaping (Data?, Error?) -> Void ) {
//    let parameters = self.prepareParams(searchTerm: searchTerm)
//    let url = self.createUrl(params: parameters)
//    var request = URLRequest(url: url)
//    request.allHTTPHeaderFields = prepareHeader()
//    request.httpMethod = "GET"
//    let task = createDataTask(from: request, completion: completion)
//    task.resume()
//}
//
//private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) ->  Void) -> URLSessionDataTask {
//    return URLSession.shared.dataTask(with: request) { (data, response, error) in
//        DispatchQueue.main.async {
//            completion(data, error)
//        }
//    }
