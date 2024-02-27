//
//  ContentView.swift
//  CoreDataTest
//
//  Created by naeem alabboodi on 2/25/24.
//

import SwiftUI
import CoreData

class ContentViewModel: ObservableObject {
    @Published var items :[Item] = []
    @Published var items2 :[Entity] = []
    var context : NSPersistentContainer = NSPersistentContainer(name: "Item")
    init() {
       
        context.loadPersistentStores { Desc, error in
            if error != nil {
                print("error loading ")
            }
        }
        fetchData()
        fetchData2()
    }
    
    
    func fetchData() {
        let request : NSFetchRequest<Item> = NSFetchRequest(entityName: "Item")
        do {
            items = try context.viewContext.fetch (request)
        }catch {
            
        }
    }
    func fetchData2() {
        let request : NSFetchRequest<Entity> = NSFetchRequest(entityName: "Entity")
        do {
            items2 = try context.viewContext.fetch (request)
        }catch {
            
        }
    }
    func save() {
        do{
           try context.viewContext.save()
        }catch {
            
        }
    }
    
    func addNewItem(name: String , age: Int) {
        let newEntity = Item(context: context.viewContext)
        newEntity.name = name
        newEntity.age = Int32(age)
        save()
    }
    func addNewItem2(name: String , age: Int) {
        let newEntity = Entity(context: context.viewContext)
        newEntity.name = name
        newEntity.age = Int16(age)
       
        save()
        fetchData2()
    }
}

struct ContentView: View {
    @StateObject var vm = ContentViewModel()
    @State var nameString = ""
    @State var age = 0
    
    var body: some View {
        VStack {
            TextField("Enter Name", text: $nameString)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                }
               
            TextField("Enter Age", value: $age, formatter: NumberFormatter())
                            .padding()
                            .background {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(lineWidth: 1.0)
                            }
            Button("add") {
                vm.addNewItem2(name: nameString, age: age)
                vm.save()
                vm.fetchData()
                nameString = ""
                age = 0
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .buttonStyle(.borderedProminent)
            Spacer()
            
            List {
                ForEach(vm.items) { item in
                    HStack {
                        Text(item.name ?? "nil")
                        Text("\(item.age)") // Use item.age instead of age
                    }
                }
            }
            List {
                ForEach(vm.items2) { item in
                    HStack {
                        Text(item.name ?? "nil")
                        Text("\(item.age)") // Use item.age instead of age
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
