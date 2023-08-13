//
//  TrendingTickersResponse.swift
//  YahooScraper
//
//  Created by Selma Suvalija on 8/13/23.
//

import Foundation

struct TrendingTickersResponse: Codable {
    let success: Bool
    let data: [String]
    let errors: [String]?
}
