//
//  SearchResults.swift
//  InterestingNumbersApp
//
//  Created by Серафима  Татченкова  on 08.05.2022.
//

import Foundation

struct SearchResults: Decodable {
    let resultString: String
}

struct SearchResultsDateJSON: Decodable {
//    let date: String?
    let text: String
//    let year: Int?
    let number: Int
    let found: Bool
    let type: String
}


