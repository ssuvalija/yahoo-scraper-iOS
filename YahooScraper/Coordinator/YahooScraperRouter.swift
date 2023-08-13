//
//  YahooScraperRouter.swift
//  YahooScraper
//
//  Created by Selma Suvalija on 8/13/23.
//

import Foundation
import SwiftUI

enum YahooScraperRouter: Routable {
    case home
    case tickerList([Ticker])

    
    public var transition: NavigationTranisitionStyle {
        switch self {
        case .home:
            return .push
        case .tickerList:
            return .push
        }
    }
    
    @ViewBuilder
    public func view() -> some View {
      switch self {
      case .home:
        TickerSelectionView()
      case .tickerList(let tickers):
        TickerListView(tickers: tickers)
      }
    }
}
