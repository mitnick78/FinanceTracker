//
//  AccountCell.swift
//  FinanceTracker
//
//  Created by Christophe on 08/10/2022.
//

import SwiftUI

struct AccountCell: View {
    @ObservedObject var  account: Account
    
    
    var body: some View {
        HStack {
            Image(account.iconName)
                .resizable()
                .padding(4)
                .frame(width: 50, height: 50)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(account.name)
                    .font(.headline)
                    .foregroundColor(.primary)
                Text("\(String(format: "%.2f", account.amount)) €")
                    .font(.footnote)
                    .foregroundColor(Color(white: 0.4))
            }
            Spacer()
            Button {
                account.isFavourite.toggle()
            } label: {
                Image(systemName: account.isFavourite ? "star.fill" : "star")
                    .foregroundColor(account.isFavourite ? .yellow : Color(white: 0.4))
            }

        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.white)
        .cornerRadius(16)
    }
}

struct AccountCell_Previews: PreviewProvider {
    static var previewAccount = Account(iconName: "icon_002", name: "Paypal", initialAmount: 3259.59, transaction: previewTransaction, currency: .euro, isFavourite: false)
    static var previews: some View {
        AccountCell(account: previewAccount)
            .padding()
            .background(Color("grey"))
            .previewLayout(.sizeThatFits)
    }
}
