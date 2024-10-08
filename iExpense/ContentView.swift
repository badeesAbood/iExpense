//
//  ContentView.swift
//  iExpense
//
//  Created by MASARAT on 7/10/2024.
//

import SwiftUI
import Observation



struct ExpenseItem : Identifiable  , Codable{
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}


@Observable
class Expenses {
    var items =  [ExpenseItem](){
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded , forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try?  JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
    }
}
  
struct ContentView: View {
    @State private var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationStack {
            List{
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name).background( item.amount < 10 ? .red : item.amount > 10 && item.amount < 100 ? .blue : .green )
                                .font(.headline)
                            Text(item.type)
                        }
                        
                        Spacer()
                        Text(item.amount, format: .currency(code: "USD"))
                    }
                        
                }.onDelete(perform: removeExpense )
            }.navigationTitle("iExpense" )
                .toolbar {
                    Button("Add Expense" , systemImage: "plus") {
                       showingAddExpense = true
                    }
                }.sheet(isPresented: $showingAddExpense){
                    AddView(expenses: expenses) 
                }
                    }    }
    
    func removeExpense(at offset: IndexSet) {
        expenses.items.remove(atOffsets: offset)
    }
  
    
}

#Preview {
    ContentView()
}
