//
//  EditableSwiftData.swift
//  ProjectSwiftData2
//
//  Created by naeem alabboodi on 2/15/24.
//

import SwiftUI
import SwiftData

struct EditableSwiftData: View {
    @Bindable var dest: Destination
    var body: some View {
            VStack {
                TextField("Name", text: $dest.name)
                TextField("Details", text: $dest.details, axis: .vertical)
                DatePicker("Data", selection: $dest.date)
                
                Section {
                    
                    Picker(selection: $dest.priority) {
                        Text("low").tag(1)
                        Text("mid").tag(2)
                        Text("high").tag(3)
                    } label: {
                        Image(systemName: "circle")
                    }

                   
                    
                }
               
            
        }
            .padding()
            Spacer()
            .navigationTitle("Edit destination")
//            .navigationBarTitleDisplayMode(.inline)
        
        
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Destination.self, configurations: config)
        let example = Destination(name: "Example", details: "This is example is working very well")
        return  EditableSwiftData(dest: example)
            .modelContainer(container)
    } catch  {
        fatalError()
    }
}
