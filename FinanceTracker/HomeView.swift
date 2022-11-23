//
//  ContentView.swift
//  FinanceTracker
//
//  Created by Christophe on 08/10/2022.
//

import SwiftUI

struct HomeView: View {
    
    @State private var isPresentedNewAccountScreen = false
    @State private var isShowingFavouritesOnly = false
    @State private var isShowingAlert = false
    @State private var isShowingNewTransactionScreen = false
    @StateObject private var accountsList = AccountsList()
    @Environment(\.scenePhase) var scenePhase
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 32) {
                    VStack(spacing: 8){
                        Text("Soldes total : ")
                        Text("\(String(format: "%.2f", accountsList.accounts.map{$0.amount}.reduce(0, +))) €")
                            .font(.system(size: 30, weight: .bold))
                    }
                    HStack{
                        AccentButton(title: "+ transaction", color: Color("purple")){
                            if accountsList.accounts.isEmpty {
                                isShowingAlert = true
                            } else {
                                isShowingNewTransactionScreen = true
                            }
                        }
                        AccentButton(title: "+ Account", color: .orange) {
                            isPresentedNewAccountScreen = true
                        }
                        
                    }
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Mes comptes")
                                .font(.title2)
                                .bold()
                            Spacer()
                            Button {
                                withAnimation {
                                    isShowingFavouritesOnly.toggle()
                                }
                            } label: {
                                Image(systemName: isShowingFavouritesOnly ? "star.fill" : "star")
                                    .foregroundColor(isShowingFavouritesOnly ? .yellow : Color(white: 0.4))
                                    .padding(.trailing)
                            }

                        }
                        if accountsList.accounts.count > 0 {
                            VStack(spacing: 16) {
                                ForEach(accountsList.accounts) { account in
                                    if !isShowingFavouritesOnly || account.isFavourite {
                                        NavigationLink {
                                            AccountDetailView(account: account)
                                                .environmentObject(accountsList)
                                        } label: {
                                            AccountCell(account: account)
                                        }
                                    }
                                }
                            }
                        } else {
                            Text("Ajoutez un compte")
                                .padding(32)
                                .frame(maxWidth: .infinity)
                        }
                    }
                }
                .padding(24)
            }
            .background(Color("grey"))
            .sheet(isPresented: $isPresentedNewAccountScreen) {
                AccountCreationView { account in
                    accountsList.accounts.append(account)
                }
            }
            .alert(isPresented: $isShowingAlert) {
                Alert(title: Text("Hop !"), message: Text("Tu dois d'abord créer un compte avant d'y associer des transactions..."),  primaryButton: .default(Text("Créer un compte"), action: {
                        isPresentedNewAccountScreen = true
                }),
                secondaryButton: .destructive(Text("Annuler"))
                )
            }
            .sheet(isPresented: $isShowingNewTransactionScreen) {
                NewTransactionView().environmentObject(accountsList)
            }
        }
        .accentColor(.black)
        .onChange(of: scenePhase) { phase in
            if phase == .inactive {
                AccountsList.save(accounts: accountsList.accounts) { result in
                    if case .failure(let error) = result {
                        fatalError(error.localizedDescription)
                    }
                }
            }
        }
        .onAppear{
            AccountsList.load { result in
                switch result {
                case .failure(let error):
                    fatalError(error.localizedDescription)
                case .success(let accounts):
                    accountsList.accounts = accounts
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
