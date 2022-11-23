//
//  TransactionCell.swift
//  FinanceTracker
//
//  Created by Christophe on 28/10/2022.
//

import SwiftUI

struct TransactionCell: View {
    @ObservedObject var transaction: Transaction
    @State private var isDetailMode = false
    @State private var isEditingMode = false
    @FocusState private var focusedField: Field?
    
    let onDelete: () -> Void
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy à HH:mm"
        return formatter
    }()
    
    var body: some View {
        VStack(spacing: 16){
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    if isEditingMode {
                        TextField("Ex: Repas du midi...", text: $transaction.label)
                            .font(.headline)
                            .focused($focusedField, equals: .label)
                    } else {
                        Text(transaction.label)
                            .font(.headline)
                    }
                    Text(dateFormatter.string(from: transaction.date))
                        .font(.footnote)
                        .foregroundColor(Color(white: 0.4))
                }
                Spacer()
                Text("\(String(format: "%.2f", transaction.amount)) \(transaction.currency.rawValue)")
            }
            if isDetailMode {
                HStack{
                    Button(action: onDelete) {
                        Text("Supprimer")
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity)
                    }
                    Button(action: {
                        isEditingMode = true
                        focusedField = .label
                    }) {
                        Text("Renommer")
                            .foregroundColor(.blue)
                            .frame(maxWidth: .infinity)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .onTapGesture {
            withAnimation {
                isDetailMode.toggle()
            }
        }
    }
    private enum Field: Int, Hashable {
        case label
    }
}

struct TransactionCell_Previews: PreviewProvider {
    static var previews: some View {
        TransactionCell(transaction: previewTransaction[0], onDelete: {})
            .previewLayout(.sizeThatFits)
            .padding(24)
            .background(Color("grey"))
            .previewLayout(.sizeThatFits)
    }
}
