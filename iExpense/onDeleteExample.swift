//
//  onDeleteExample.swift
//  iExpense
//
//  Created by SCOTT CROWDER on 10/30/23.
//

import SwiftUI

struct onDeleteExample: View {
    @State private var numbers: [Int] = [Int]()
    @State private var currentNumber: Int = 1
    
    var body: some View {
        NavigationStack {
            VStack {
                List{
                    ForEach(numbers, id: \.self) {
                        Text("Row \($0)")
                    }
                    .onDelete(perform: removeRows)
                }
                
                Button {
                    numbers.append(currentNumber)
                    currentNumber += 1
                } label: {
                    Text("Add Number")
                }
                .frame(width: 200, height: 30)
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(.rect(cornerRadius: 20))
            }
            .navigationTitle("List of Items")
            .toolbar {
                EditButton()
            }
        }
        
        
    }
    
    func removeRows(at offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }
}

#Preview {
    onDeleteExample()
}
