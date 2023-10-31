//
//  UserConfigurations.swift
//  iExpense
//
//  Created by SCOTT CROWDER on 10/31/23.
//

import SwiftUI

struct UserConfigurations: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var lowAmount: Double = UserDefaults.standard.double(forKey: "lowAmount") == 0 ? 10 : 
        UserDefaults.standard.double(forKey: "lowAmount")
    @State private var highAmount: Double = UserDefaults.standard.double(forKey: "highAmount") == 0 ? 100 : UserDefaults.standard.double(forKey: "highAmount")
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Text("You can set the amount levels when the colors of the expenses will change.")
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
            .navigationTitle("User Configurations")
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
