//
//  UserConfigurations.swift
//  iExpense
//
//  Created by SCOTT CROWDER on 10/31/23.
//

import SwiftUI

struct UserConfigurations: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var lowAmount: Double = 10
    @State private var highAmount: Double = 100
    
    var body: some View {
        VStack {
            Form {
                Section("Low Amount") {
                    TextField("Amount", value: $lowAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                
                Section("High Amount") {
                    TextField("Amount", value: $highAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            
            ExpenseButton(label: "Save Configurations") {
                UserDefaults.standard.set(lowAmount, forKey: "lowAmount")
                UserDefaults.standard.set(highAmount, forKey: "highAmount")
                dismiss()
            }
        }
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
    UserConfigurations()
}
