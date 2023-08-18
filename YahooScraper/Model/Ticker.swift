//
//  Ticker.swift
//  YahooScraper
//
//  Created by Selma Suvalija on 8/12/23.
//

import Foundation

struct Ticker: Codable {
  let tickerId: Int
  let tickerSymbol: String
  let companyName: String
  let marketCap: String
  let yearFounded: Int
  let numberOfEmployees: Int
  let city: String?
  let state: String?
  let country: String?
  var stockPriceDtoList: [StockPrice]
  var lastUpdated: String
}





