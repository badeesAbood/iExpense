//
//  AddView.swift
//  iExpense
//
//  Created by MASARAT on 8/10/2024.
//

import SwiftUI

struct AddView: View {
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount =  0.0
    @Environment(\.dismiss) var dissmiss
    var expenses : Expenses
    let types = [ "Personal" , "Business"]
    
    
    var body: some View {
        NavigationStack {
            Form {
                 TextField("name" , text: $name)
                Picker("type" , selection: $type) {
                    ForEach(types , id: \.self ) {
                        Text($0)
                    }
                }
                
                TextField("amount" , value: $amount , format: .currency(code: "USD")).keyboardType(.decimalPad )
                
                
            }.navigationTitle("Add New Expense ").toolbar {
                Button("Save") {
                    let item = ExpenseItem(name: name, type: type, amount: amount)
                    expenses.items.append(item)
                    dissmiss()
                }
            }
        }
    }
}

#Preview {
    AddView(expenses: Expenses())
}
