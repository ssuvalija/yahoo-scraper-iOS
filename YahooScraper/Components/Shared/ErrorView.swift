//
//  ErrorView.swift
//  YahooScraper
//
//  Created by Selma Suvalija on 8/18/23.
//

import SwiftUI

struct ErrorView: View {
  let errorMessage: String
  let onDismiss: () -> Void

  
  var body: some View {
    VStack {
      Image(systemName: "exclamationmark.triangle.fill")
        .font(.system(size: 50))
        .foregroundColor(.red)
      
      Text(errorMessage)
        .foregroundColor(.red)
        .multilineTextAlignment(.center)
        .padding()
      
      Button("Back", action: onDismiss)
        .padding(.horizontal, 30)
        .padding(.vertical, 15)
        .background(Color.gray)
        .foregroundColor(.white)
        .cornerRadius(10)
      
    }
  }
}


struct ErrorView_Previews: PreviewProvider {
  static var previews: some View {
    ErrorView(errorMessage: "Error occurred", onDismiss: {})
  }
}
