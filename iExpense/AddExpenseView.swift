//
//  AddExpenseView.swift
//  iExpense
//
//  Created by SCOTT CROWDER on 10/30/23.
//

import SwiftUI

struct AddExpenseView: View {
    @State private var name: String = ""
    @State private var type: String = "Personal"
    @State private var amount: Double = 0.0
    
    let types: [String] = ["Personal", "Business"]
    
    var expenses: Expenses
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Amount", value: $amount, format: .currency(code: "USD"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add new expense")
            .toolbar {
                Button("Save Expense") {
                    let expenseItem: ExpenseItem = ExpenseItem(name: name, type: type, amount: amount)
                    expenses.items.append(expenseItem)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    AddExpenseView(expenses: Expenses())
}
