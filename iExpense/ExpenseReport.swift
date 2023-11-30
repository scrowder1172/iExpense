//
//  ExpenseReport.swift
//  iExpense
//
//  Created by SCOTT CROWDER on 10/31/23.
//

import SwiftUI
import SwiftData

struct ExpenseReport: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Expense.name) var expenses: [Expense]
    
    @State private var businessExpenses: String = ""
    @State private var personalExpenses: String = ""
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Text("Expense Report")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).bold().underline()
                .offset(x: 0, y: -150)
            Text("Personal Expenses: \(personalExpenses)")
            Text("Business Expenses: \(businessExpenses)")
            ExpenseButton(label: "Close Report") {
                dismiss()
            }
            .offset(x: 0, y: 150)
            
        }
        .onAppear(perform: getExpenses)
    }
    
    private func calculateBusinessExpenses() -> Double {
        var total: Double = 0.0
        for item in expenses {
            if item.type == ExpenseType.business.rawValue {
                total += item.amount
            }
        }
        return total
    }
    
    private func calculatePersonalExpenses() -> Double {
        var total: Double = 0.0
        for item in expenses {
            if item.type == ExpenseType.personal.rawValue {
                total += item.amount
            }
        }
        return total
    }
    
    func getExpenses() {
        businessExpenses = formatAsCurrency(calculateBusinessExpenses())
        personalExpenses = formatAsCurrency(calculatePersonalExpenses())
        
    }
    
    func formatAsCurrency(_ amount: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = Locale.current.currency?.identifier ?? "USD"

        if let formattedAmount = formatter.string(from: NSNumber(value: amount)) {
            return formattedAmount
        } else {
            return "Error formatting amount"
        }
    }
}

#Preview {
    ExpenseReport()
}
