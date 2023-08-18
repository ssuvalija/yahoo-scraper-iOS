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
          navigationLinkView
        } else {
          if let error = viewModel.error {
            errorView(errorMessage: error)
          } else {
            mainContentView
          }
        }
      }
      .navigationTitle("Yahoo Scraper")
      .navigationBarTitleDisplayMode(.inline)
      .onAppear() {
        viewModel.fetchTrendingTickers()
      }
    }
  }
  
  // Navigation Link View
  private var navigationLinkView: some View {
    NavigationLink(destination: TickerListView(tickers: viewModel.tickers), isActive: $viewModel.showTickerListView) {
      EmptyView()
    }
  }
  
  // Error View
  private func errorView(errorMessage: String) -> some View {
    ErrorView(errorMessage: errorMessage, onDismiss: {
      viewModel.error = nil
    })
  }
  
  // Main Content View
  private var mainContentView: some View {
    VStack {
      Form {
        tickersSection
        selectDateSection
      }
      fetchDataButton
    }
    .overlay(
      ZStack {
        if viewModel.isLoading {
          Color.black.opacity(0.3)
          loaderView
        }
      }
        .frame(width: 80, height: 80)
        .cornerRadius(10)
    )
  }
  
  // Tickers Section
  private var tickersSection: some View {
    Section(header: Text("Enter Tickers")) {
      ScrollView {
        TickerEntryView(tickers: $viewModel.selectedTickers)
          .frame(height: 400)
      }
    }
  }
  
  // Select Date Section
  private var selectDateSection: some View {
    Section(header: Text("Select Date")) {
      DatePicker("Select Date", selection: $viewModel.selectedDate, in: ...Date(), displayedComponents: .date)
        .datePickerStyle(.compact)
    }
  }
  
  // Fetch Data Button
  private var fetchDataButton: some View {
    Button(action: {
      viewModel.fetchStockDataForSelectedTickers()
    }) {
      Text("Fetch Data")
        .padding()
        .background(Color.blue)
        .foregroundColor(.white)
        .cornerRadius(10)
    }
    .disabled(viewModel.selectedTickers.isEmpty)
  }
  
  private var loaderView: some View {
    ProgressView()
      .progressViewStyle(CircularProgressViewStyle())
      .frame(width: 40, height: 40)
  }
}

struct TickerSelectionView_Previews: PreviewProvider {
  static var previews: some View {
    TickerSelectionView()
  }
}
