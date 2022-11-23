//
//  Currency.swift
//  FinanceTracker
//
//  Created by Christophe on 10/10/2022.
//

import Foundation

enum Currency: String, CaseIterable, Codable {
    case dollar = "$"
    case euro = "€"
    case ruble = "₽"
    case sterling = "£"
    case yen = "¥"
    
    var iconName: String {
        switch self {
        case .dollar :
            return "dollarsign.circle"
        case .euro :
            return "eurosign.circle"
        case .ruble :
            return "rublesign.circle"
        case .sterling :
            return "sterlingsign.circle"
        case .yen :
            return "dollarsign.circle"
        }
    }
    
    var filledIconName: String {
        return "\(iconName).fill"
    }
}
