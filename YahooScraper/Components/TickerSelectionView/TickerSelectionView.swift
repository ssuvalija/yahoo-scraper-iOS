//
//  ContentView.swift
//  YahooScraper
//
//  Created by Selma Suvalija on 8/12/23.
//

import SwiftUI

struct TickerSelectionView: View {
  @ObservedObject var viewModel = TickerSelectionViewModel()
  
  var body: some View {
    NavigationView {
      VStack {
        if viewModel.showTickerListView {
          NavigationLink(destination: TickerListView(tickers: viewModel.tickers), isActive: $viewModel.showTickerListView) {
            EmptyView()
          }
        } else {
          VStack {
            Form {
              Section(header: Text("Select Tickers")) {
                Toggle(isOn: $viewModel.selectAllTickers) {
                  Text("Select All")
                }
                ForEach(viewModel.trendingTickers, id: \.self) { ticker in
                  Toggle(isOn: Binding(
                    get: { viewModel.selectedTickers.contains(ticker) },
                    set: { isSelected in
                      if isSelected {
                        viewModel.selectedTickers.insert(ticker)
                      } else {
                        viewModel.selectedTickers.remove(ticker)
                      }
                    })) {
                      Text(ticker)
                    }
                }
              }
              
              Section(header: Text("Select Date")) {
                DatePicker("Select Date", selection: $viewModel.selectedDate, in: ...Date() , displayedComponents: .date)
                  .datePickerStyle(GraphicalDatePickerStyle())
              }
            }
            
            Spacer()
            
            Button(action: {
              viewModel.fetchStockDataForSelectedTickers()
            }) {
              Text("Fetch Data")
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .disabled(viewModel.selectedTickers.isEmpty) // Disable button if no tickers selected
          }
        }
      }
      .navigationTitle("Trending Tickers")
      .navigationBarTitleDisplayMode(.inline)
      .onAppear() {
        viewModel.fetchTrendingTickers()
      }
    }
  }
}

struct TickerSelectionView_Previews: PreviewProvider {
  static var previews: some View {
    TickerSelectionView()
  }
}
