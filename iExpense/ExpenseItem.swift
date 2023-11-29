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


@Model final class ExpenseItem {
    let name: String
    var type: ExpenseType
    let amount: Double
    var dateAdded: Date = Date()
    
    init(name: String, type: ExpenseType, amount: Double) {
        self.name = name
        self.type = type
        self.amount = amount
    }
}

/*
 struct ExpenseThing: Identifiable, Codable {
     // struct containing expense details
     // added Codable to allow for encoding and decoding of items
     var id: UUID = UUID()
     let name: String
     let type: String
     let amount: Double
     var dateAdded: Date = Date()
 }
 
 */
