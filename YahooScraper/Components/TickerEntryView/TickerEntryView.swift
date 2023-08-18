//
//  TickerEntryView.swift
//  YahooScraper
//
//  Created by Selma Suvalija on 8/16/23.
//

import SwiftUI

struct TickerEntryView: View {
  @Binding var tickers: [String]
  @State private var newTicker = ""
  
  var body: some View {
    VStack {
      
      List {
        ForEach(tickers, id: \.self) { ticker in
          Text(ticker)
        }
        .onDelete(perform: deleteTicker)
      }
      .listStyle(PlainListStyle())
      
      HStack {
        TextField("Enter Ticker", text: $newTicker)
          .textFieldStyle(RoundedBorderTextFieldStyle())
          .padding()
        
        Button(action: {
          addTicker()
        }) {
          Text("Add")
        }
        .padding()
      }
    }
    .padding()
  }
  
  func addTicker() {
    if !newTicker.isEmpty {
      let separatedStrings = newTicker.components(separatedBy: ",").map { String($0).trimmingCharacters(in: .whitespacesAndNewlines).uppercased() }
      
      tickers += separatedStrings
      
      newTicker = ""
    }
  }
  
  func deleteTicker(at offsets: IndexSet) {
    tickers.remove(atOffsets: offsets)
  }
}

struct TickerEntryView_Previews: PreviewProvider {
  static var previews: some View {
    TickerEntryView(tickers: .constant(["AAPL", "GOOGL"]))
  }
}
