//
//  ContentView.swift
//  Devote
//
//  Created by Ussama Irfan on 01/07/2024.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    // MARK: - PROPERTY
    @State private var task: String = ""
    
    private var isButtonDisabled: Bool {
        task.isEmpty
    }
    
    @FocusState private var taskTextFieldFocused: Bool
    
    // MARK: FETCH DATA
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    
    // MARK: - FUNCTIONS
    private func addItem() {
        
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.task = task
            newItem.completion = false
            newItem.id = UUID()
            
            do {
                try viewContext.save()
                
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
            
            task = ""
            taskTextFieldFocused = false
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
                
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    // MARK: - BODY
    var body: some View {
        
        NavigationStack {
            
            ZStack {
                VStack {
                    
                    VStack(spacing: 16) {
                        
                        TextField("New Task", text: $task)
                            .padding()
                            .background(
                                Color(.systemGray6)
                            )
                            .clipShape(
                                RoundedRectangle(cornerRadius: 10)
                            )
                            .focused($taskTextFieldFocused)
                        
                        Button(action: {
                            addItem()
                            
                        }, label: {
                            Spacer()
                            Text("SAVE")
                            Spacer()
                        })
                        .disabled(isButtonDisabled)
                        .padding()
                        .font(.footnote)
                        .foregroundStyle(.white)
                        .background(isButtonDisabled ? Color.gray : Color.pink)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 10)
                        )
                        
                    } //: VSTACK
                    .padding()
                    
                    List {
                        
                        ForEach(items) { item in
                            
                            NavigationLink {
                                Text("Item at \(item.timestamp!, formatter: itemFormatter)")
                                
                            } label: {
                                
                                VStack(alignment: .leading) {
                                    
                                    Text(item.task ?? "")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                    
                                    Text(item.timestamp!, formatter: itemFormatter)
                                        .font(.footnote)
                                        .foregroundStyle(.gray)
                                }
                            }
                        }
                        .onDelete(perform: deleteItems)
                    } //: LIST
                    .listStyle(.insetGrouped)
                    .scrollContentBackground(.hidden)
                    .shadow(color: .black.opacity(0.3), radius: 12)
                    .padding(.vertical, 0)
                    .frame(maxWidth: 640)
                } //: VSTACK
            }
            .navigationTitle("Daily Tasks")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing ) {
                    EditButton()
                }
            }//: TOOLBAR
            .background(
                BackgroundImageView()
            )
            .background(
                backgroundGradient
            )
        }//: NAVIGATION STACK
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
