//
//  PreviewData.swift
//  FinanceTracker
//
//  Created by Christophe on 09/10/2022.
//

import Foundation

let previewAccounts = [
    Account(iconName: "icon_002", name: "PayPal", initialAmount: 289.56, transaction: previewTransaction, currency: .euro, isFavourite: false),
    Account(iconName: "icon_007", name: "Binance", initialAmount: 3656.54, transaction: [], currency: .euro, isFavourite: true),
    Account(iconName: "icon_001", name: "Bourso", initialAmount: 2718.45, transaction: [], currency: .euro, isFavourite: false)
]


let previewTransaction = [
    Transaction(label: "Repas du midi", amount: 8.98, currency: .euro, date: Date()),
    Transaction(label: "Transport", amount: 16.00, currency: .euro, date: Date()),
    Transaction(label: "Loyer", amount: 1138, currency: .euro, date: Date())
    ]
