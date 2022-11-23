//
//  AccountDetailView.swift
//  FinanceTracker
//
//  Created by Christophe on 30/10/2022.
//

import SwiftUI

struct AccountDetailView: View {
    @ObservedObject var account: Account
    @State private var isPresentingNewTransactionScreen = false
    @State private var isShowingAlert = false
    @State private var isShowingTransactionAlert = false
    @State private var isEditingMode = false
    @EnvironmentObject var accountsList: AccountsList
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedTrabsactionToDelete: Transaction? = nil
    @FocusState private var focusedField: Field?
    
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                HStack {
                    if isEditingMode {
                        TextField("Entrez un nom...", text: $account.name)
                            .font(.system(size: 32, weight: .bold))
                            .focused($focusedField, equals: .name)
                    } else {
                        Text(account.name)
                            .font(.system(size: 32, weight: .bold))
                    }
                    
                    Spacer()
                    Text("\(String(format: "%.2f", account.amount)) \(account.currency.rawValue)")
                        .font(.system(size: 32, weight: .light))
                }
                AccentButton(title: "+ transaction", color: Color("purple")) {
                    isPresentingNewTransactionScreen = true
                }
                Divider()
                VStack(spacing: 16) {
                    if account.transactions.isEmpty {
                        Text("Aucune transaction pour le moment...")
                            .font(.callout)
                            .foregroundColor(Color(white: 0.4))
                    }
                    ForEach(account.transactions) { transaction in
                        TransactionCell(transaction: transaction, onDelete: {
                            isShowingTransactionAlert = true
                            selectedTrabsactionToDelete = transaction
                        })
                    }
                    Text("solde initial: \(String(format: "%.2f", account.initialAmount)) \(account.currency.rawValue)")
                        .font(.callout)
                        .foregroundColor(Color(white: 0.4))
                        .padding()
                }
            }
            .padding()
        }
        .background(Color("grey"))
        .sheet(isPresented: $isPresentingNewTransactionScreen) {
            NewTransactionView()
        }
        .toolbar {
            Menu {
                Button {
                    isEditingMode = true
                    focusedField = .name
                } label: {
                    Label("Renommer", systemImage: "pencil")
                }
                
                Button(role: .destructive) {
                    isShowingAlert = true
                } label: {
                    Label("Supprimer", systemImage: "trash")
                }

            } label: {
                Image(systemName: "slider.horizontal.3")
                            .foregroundColor(.primary)
            }

        }
        .alert(isPresented: $isShowingAlert) {
            Alert(
                title: Text("Attends !"),
                message: Text("Es-tu sûr de supprimer ce compte ?  "),
                primaryButton: .destructive(Text("Supprimer"), action: {
                    accountsList.accounts.removeAll { element in
                        element.id == account.id
                    }
                    
                    presentationMode.wrappedValue.dismiss()
                }),
                secondaryButton: .default(Text("Annuler")))
        }
        .alert(isPresented: $isShowingTransactionAlert) {
            Alert(
                title: Text("Hmm..."),
                message: Text("Tu es sur le point de supprimer la transaction  Cette transaction sera perdu à jamais."),
                primaryButton: .destructive(Text("Supprimer"), action: {
                    withAnimation {
                        account.transactions.removeAll { transaction in
                            return selectedTrabsactionToDelete!.id == transaction.id
                        }
                    }
                    
                    selectedTrabsactionToDelete = nil
                }),
                secondaryButton: .default(Text("Annuler")))
        }
    }
    
    private enum Field: Int, Hashable {
        case name
    }
}


struct AccountDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AccountDetailView(account: previewAccounts[0])
    }
}
