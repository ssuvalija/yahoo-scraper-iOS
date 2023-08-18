//
//  TickerListCell.swift
//  YahooScraper
//
//  Created by Selma Suvalija on 8/13/23.
//

import SwiftUI

struct TickerListCell: View {
  let ticker: Ticker
  
  var body: some View {
    
    VStack(alignment: .leading) {
      Text(ticker.tickerSymbol + " - " + ticker.companyName)
        .font(.headline)
      
      Text(ticker.stockPriceDtoList.first?.marketOpen ?? false ? "Market is open" : "Market is closed")
        .font(.caption)
        .foregroundColor(.gray)
      
      Spacer(minLength: 10)
      
      HStack {
        VStack(alignment: .leading) {
          Text("Year Founded: \(ticker.yearFounded)")
            .font(.caption)
          Text("Number of Employees: \(ticker.numberOfEmployees)")
            .font(.caption)
          Text("City: \(ticker.city ?? "N/A")")
            .font(.caption)
          Text("State: \(ticker.state ?? "N/A")")
            .font(.caption)
          Text("Country: \(ticker.country ?? "N/A")")
            .font(.caption)
        }
        
        VStack(alignment: .leading) {
          Text("Market Cap: \(ticker.marketCap)")
            .font(.caption)
          
          if let openPrice = ticker.stockPriceDtoList.first?.openPrice {
            let stringValue = String(describing: openPrice)
            Text("Open Price: \(stringValue)")
              .font(.caption)
          }
          
          if let previousClosePrice = ticker.stockPriceDtoList.first?.previousClosePrice {
            let stringValue = String(describing: previousClosePrice)
            Text("Previous Close: \(stringValue)")
              .font(.caption)
          }
          
          Text("Date: \(ticker.stockPriceDtoList.first?.date ?? Date().description)")
            .font(.caption)
          Text("Last Updated: \(ticker.lastUpdated)")
            .font(.caption)
          
        }
      }
    }
  }
  
}

struct TickerListCell_Previews: PreviewProvider {
  static let ticker = Ticker(tickerId: 1, tickerSymbol: "BA", companyName: "The Boeing Company", marketCap: "12.34B", yearFounded: 1916, numberOfEmployees: 12000, city: "Washington", state: "WA", country: "United States", stockPriceDtoList: [], lastUpdated: "2023.08.13")
  static var previews: some View {
    TickerListCell(ticker: ticker)
  }
}
