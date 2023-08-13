//
//  TickerSelectionViewModel.swift
//  YahooScraper
//
//  Created by Selma Suvalija on 8/12/23.
//

import Foundation

class TickerSelectionViewModel: ObservableObject {
  @Published var selectedTickers: Set<String> = []
  @Published var selectAllTickers: Bool = false {
    didSet {
      if selectAllTickers {
        selectedTickers = Set(trendingTickers)
      } else {
        selectedTickers.removeAll()
      }
    }
  }
  @Published var selectedDate = Date()
  @Published var trendingTickers: [String] = ["AAPL", "GOOGL", "MSFT", "BA"]
  @Published var showTickerListView: Bool = false
  @Published var tickers: [Ticker] = []
  
  
  func fetchStockDataForSelectedTickers() {
    let path = "/stock-data"
    
    let requestBody: [String: Any] = [
      "date": extractDateFromDate(selectedDate),
      "tickers": Array(selectedTickers)
    ]
    
    do {
      let jsonData = try JSONSerialization.data(withJSONObject: requestBody)
      APIManager.shared.sendRequest(path: path, method: "POST", body: jsonData) { (result: Result<TickerListResponse, Error>) in
        DispatchQueue.main.async {
          
          switch result {
          case .success(let response):
            let inputFormatter = DateFormatter()
            inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
            
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            
            self.tickers = response.data
            
            for (index, ticker) in self.tickers.enumerated() {
              if let date = inputFormatter.date(from: ticker.lastUpdated) {
                let formattedDateString = outputFormatter.string(from: date)
                self.tickers[index].lastUpdated = formattedDateString
              }
            }
            self.showTickerListView = true
            print(response)
          case .failure(let error):
            print("Error fetching data: \(error)")
          }
        }
      }
    } catch {
      print("Error creating JSON data: \(error)")
    }
    
  }
  
  func fetchTrendingTickers() {
    let path = "/trending-tickers"
    
    APIManager.shared.sendRequest(path: path, method: "GET") { (result: Result<TrendingTickersResponse, Error>) in
      DispatchQueue.main.async {
        switch result {
        case .success(let response):
          self.trendingTickers = response.data
        case .failure(let error):
          print("Error fetching data: \(error)")
        }
      }
    }
  }
  
  func extractDateFromDate(_ date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    
    return dateFormatter.string(from: date)
  }
  
}
