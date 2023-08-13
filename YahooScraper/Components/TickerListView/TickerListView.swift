//
//  TickerListView.swift
//  YahooScraper
//
//  Created by Selma Suvalija on 8/12/23.
//

import SwiftUI

struct TickerListView: View {
  let tickers: [Ticker]
  
  var body: some View {
    Group {
      List(tickers, id: \.tickerId) { ticker in
          TickerListCell(ticker: ticker)
      }
      .navigationTitle("Ticker List")
      .navigationBarTitleDisplayMode(.inline)
    }
  }
}


struct TickerListView_Previews: PreviewProvider {
  static let ticker = Ticker(tickerId: 1, tickerSymbol: "BA", companyName: "The Boeing Company", marketCap: "12.34B", yearFounded: 1916, numberOfEmployees: 12000, city: "Washington", state: "WA", country: "United States", stockPriceDtoList: [], lastUpdated: "2023.08.13")
  static var previews: some View {
    TickerListView(tickers: [ticker])
  }
}





