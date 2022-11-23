//
//  NewTransactionView.swift
//  FinanceTracker
//
//   on 21/06/2022.
//
import SwiftUI

struct NewTransactionView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var accountsList: AccountsList
    @State private var selectedAccountIndex = 0
    @State private var textFieldAmount = ""
    @State private var transactionName = ""
    @State private var transactionDate = Date()
    @State private var isPresentingNewAccountScreen = false

    var body: some View {
        VStack(spacing: 32) {
            Text("Nouvelle transaction")
                .font(.system(size: 32, weight: .bold))
                .padding(.top, 32)
            HStack {
                TextField("0.00", text: $textFieldAmount)
                    .keyboardType(.numbersAndPunctuation)
                    .submitLabel(.done)
                    .font(.system(size: 48, weight: .semibold))
                    .foregroundColor(Color.black.opacity(0.4))
                    .frame(width: nil, height: nil, alignment: .trailing)
                Text(accountsList.accounts[selectedAccountIndex].currency.rawValue)
                    .font(.system(size: 24, weight: .light))
            }
            .multilineTextAlignment(.center)
            VStack(spacing: 16) {
                AccountSelectorMenu(accountList: accountsList, selectedAccountIndex: $selectedAccountIndex, onCreateAccountButtonPressed: {
                    isPresentingNewAccountScreen = true
                })
                TextField("Ex : Loyer...", text: $transactionName)
                    .submitLabel(.done)
                    .padding(12)
                    .padding(.horizontal, 12)
                    .background(Color.white)
                    .cornerRadius(.infinity)
                DatePicker("Date :", selection: $transactionDate)
                    .padding(.leading, 24)
                    .padding(.trailing, 8)
            }
            Spacer()
            MainButton(title: "Ajouter") {
                let newTransaction = Transaction(
                    label: transactionName,
                    amount: Float(textFieldAmount) ?? 0.0,
                    currency: accountsList.accounts[selectedAccountIndex].currency,
                    date: transactionDate
                )
                accountsList.accounts[selectedAccountIndex].transactions.append(newTransaction)
                print(selectedAccountIndex)
                presentationMode.wrappedValue.dismiss()
            }
        }.sheet(isPresented: $isPresentingNewAccountScreen, content: {
            AccountCreationView { newAccount in
                accountsList.accounts.append(newAccount)
            }
        })
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color("grey"))
    }
}

struct NewTransactionView_Previews: PreviewProvider {
    static var previews: some View {
        NewTransactionView()
            .environmentObject(AccountsList(accounts: previewAccounts))
    }
}
