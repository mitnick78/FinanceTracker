//
//  Account.swift
//  FinanceTracker
//
//  Created by Christophe on 09/10/2022.
//

import Foundation

class Account: Identifiable, ObservableObject, Codable {
    
    var id = UUID()
    let iconName: String
    @Published var name: String
    let initialAmount: Float
    @Published var transactions: [Transaction]
    let currency: Currency
    var amount: Float {
        return initialAmount + transactions.map{$0.amount }.reduce(0, +)
    }
    @Published var isFavourite: Bool
    
    init(iconName: String, name: String, initialAmount: Float, transaction:[Transaction], currency: Currency, isFavourite: Bool = false) {
        self.iconName = iconName
        self.name = name
        self.initialAmount = initialAmount
        self.transactions = transaction
        self.currency = currency
        self.isFavourite = isFavourite
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.iconName = try container.decode(String.self, forKey: .iconName)
        self.initialAmount = try container.decode(Float.self, forKey: .initialAmount)
        self.currency = try container.decode(Currency.self, forKey: .currency )
        self.transactions = try container.decode([Transaction].self, forKey: .transactions)
        self.isFavourite = try container.decode(Bool.self, forKey: .isFavourite)
    }
    
    enum CodingKeys: CodingKey {
        case id
        case iconName
        case name
        case initialAmount
        case currency
        case transactions
        case isFavourite
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(iconName, forKey: .iconName)
        try container.encode(name, forKey: .name)
        try container.encode(initialAmount, forKey: .initialAmount)
        try container.encode(currency.rawValue, forKey: .currency)
        try container.encode(transactions, forKey: .transactions)
        try container.encode(isFavourite, forKey: .isFavourite)
    }
}
