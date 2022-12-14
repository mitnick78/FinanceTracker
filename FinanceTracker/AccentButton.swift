//
//  AccentButton.swift
//  FinanceTracker
//
//  Created by Christophe on 18/10/2022.
//

import SwiftUI

struct AccentButton: View {
    let title: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .foregroundColor(.black)
                .font(.callout)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
                .padding(8)
                .background(color)
                .cornerRadius(10)
                
        }
    }
}

struct AccentButton_Previews: PreviewProvider {
    
    static var previews: some View {
        AccentButton(title: "Test Button", color: .blue, action: {})
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
