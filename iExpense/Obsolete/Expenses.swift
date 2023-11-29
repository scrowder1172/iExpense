//
//  Expenses.swift
//  iExpense
//
//  Created by SCOTT CROWDER on 11/29/23.
//

import Foundation

struct ExpenseThing: Identifiable, Codable {
    // struct containing expense details
    // added Codable to allow for encoding and decoding of items
    var id: UUID = UUID()
    let name: String
    let type: String
    let amount: Double
    var dateAdded: Date = Date()
}

@Observable
class Expenses {
    // class containing an array of expenses
    var items: [ExpenseThing] = [ExpenseThing]() {
        didSet {
            // save items as they are added
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        // check if items exist and reload them otherwise create empty array
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseThing].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        
        items = []
    }
    
    func calculateBusinessExpenses() -> Double {
        var total: Double = 0.0
        for item in items {
            if item.type == "Business" {
                total += item.amount
            }
        }
        return total
    }
    
    func calculatePersonalExpenses() -> Double {
        var total: Double = 0.0
        for item in items {
            if item.type == "Personal" {
                total += item.amount
            }
        }
        return total
    }
}
