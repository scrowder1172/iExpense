//
//  ExpenseItem.swift
//  iExpense
//
//  Created by SCOTT CROWDER on 11/29/23.
//

import Foundation
import SwiftData

@Model final class ExpenseItem {
    var id: UUID = UUID()
    let name: String
    let type: String
    let amount: Double
    var dateAdded: Date = Date()
    
    init(id: UUID, name: String, type: String, amount: Double, dateAdded: Date) {
        self.id = id
        self.name = name
        self.type = type
        self.amount = amount
        self.dateAdded = dateAdded
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
