//
//  TickerListResponse.swift
//  YahooScraper
//
//  Created by Selma Suvalija on 8/13/23.
//

import Foundation

struct TickerListResponse: Codable {
    let success: Bool
    let data: [Ticker]
    let errors: [String]?
}
