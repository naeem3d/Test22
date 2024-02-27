//
//  ContentView.swift
//  ProjectSwiftData2
//
//  Created by naeem alabboodi on 2/15/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @State private var text = ""
    @State private var details = ""
    @Query var destination: [Destination]
    @Environment(\.modelContext) var context
    
    var body: some View {
        NavigationStack {
            Image(systemName: "circle")
            Rectangle()
                .frame(height: 2)
                .padding(.horizontal)
            VStack {
                TextField("Enter new ITem", text: $text)
                    .padding()
                    .overlay {
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(lineWidth: 2)
                    }
                   
                TextField("Enter Details", text: $details)
                    .padding()
                    .overlay {
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(lineWidth: 2)
                    }
               
            }
            .padding(.horizontal)
            List {
                ForEach(destination) {dest in
                    NavigationLink(value: dest) {
                        VStack(alignment: .leading) {
                            Text(dest.name)
                                .font(.headline)
                            Text(dest.date.formatted(date: .long, time: .shortened))
                                
                        }
                    }
                    
                    
                }
                .onDelete(perform: deletItem)
            }
            .navigationTitle("List of SwiftData")
            .navigationDestination(for: Destination.self, destination: EditableSwiftData.init)
            .toolbar{
                Button("Add") {
                    addNew(itemText: text, Details: details)
                    text = ""
                    details = ""
                }
            }
        }
    }
    func deletItem(_ indexSet : IndexSet) {
        for index in indexSet {
            let destination = destination[index]
            context.delete(destination)
        }
    }
    func addNew(itemText: String, Details: String) {
        let newitem = Destination(name: itemText, details: Details)
        context.insert(newitem)
       
        
        
    }
}

#Preview {
    ContentView()
}
