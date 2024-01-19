//
//  ExpenseItem.swift
//  iExpense
//
//  Created by SCOTT CROWDER on 11/29/23.
//

import Foundation
import SwiftData

enum ExpenseType: String, Codable, Identifiable, CaseIterable {
    var id: String { self.rawValue }
    case personal = "Personal"
    case business = "Business"
}

@Model final class Expense {
    let name: String
    var type: String
    let amount: Double
    var dateAdded: Date = Date()
    
    var currency_amount: String {
        //amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD")
        amount.formatted(.currency(code: Locale.current.currency?.identifier ?? "USD"))
        
    }
    
    init(name: String, type: String, amount: Double) {
        self.name = name
        self.type = type
        self.amount = amount
    }
}
