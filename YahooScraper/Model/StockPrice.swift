//
//  StockPrice.swift
//  YahooScraper
//
//  Created by Selma Suvalija on 8/13/23.
//

import Foundation

struct StockPrice: Codable {
    let stockPriceId: Int
    let date: String
    let previousClosePrice: Decimal
    let openPrice: Decimal
    var lastUpdated: String
    let marketOpen: Bool
}
