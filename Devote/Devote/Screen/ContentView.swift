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
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    @State private var task = ""
    @State private var showNewTaskItem = false
        
    // MARK: FETCH DATA
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    
    // MARK: - FUNCTIONS
    
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
                    
                    // MARK: - HEADER
                    HStack(spacing: 20) {
                        
                        // TITLE
                        Text("Devote")
                            .font(.system(.largeTitle, design: .rounded))
                            .fontWeight(.heavy)
                            .padding(.leading, 4)
                        
                        Spacer()
                        
                        
                        // EDIT BUTTON
                        EditButton()
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                            .padding(.horizontal, 10)
                            .frame(minWidth: 70, minHeight: 24)
                            .background(
                                Capsule()
                                    .stroke(.white , lineWidth: 2)
                            )
                        
                        // APPEARENCE BUTTON
                        
                        Button(action: {
                            isDarkMode.toggle()
                            playSound(sound: "sound-tap", type: "mp3")
                            hapticFeedBack.notificationOccurred(.success)
                            
                        }, label: {
                            Image(systemName: isDarkMode ? "moon.circle.fill" : "moon.circle")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .font(.system(.title, design: .rounded))
                        })
                      
                    }//: HSTACK
                    .padding()
                    .foregroundStyle(.white)
                    
                    Spacer(minLength: 80)
                    
                    // MARK: - NEW TASK BUTTON
                    
                    Button(action: {
                        showNewTaskItem = true
                        playSound(sound: "sound-ding", type: "mp3")
                        hapticFeedBack.notificationOccurred(.success)
                        
                    }, label: {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 30, weight: .semibold, design: .rounded))
                        
                        Text("New Task")
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                    })
                    .foregroundStyle(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 15)
                    .background(
                        LinearGradient(colors: [.pink, .blue], startPoint: .leading, endPoint: .trailing)
                            .clipShape(.capsule )
                    )
                    .shadow(color: .black.opacity(0.25), radius: 8, x: 0, y: 4)
                    
                    // MARK: - TASKS
                    List {
                        
                        ForEach(items) { item in
                            ListRowItemView(item: item)
                        }
                        .onDelete(perform: deleteItems)
                    } //: LIST
                    .listStyle(.insetGrouped)
                    .scrollContentBackground(.hidden)
                    .shadow(color: .black.opacity(0.3), radius: 12)
                    .padding(.vertical, 0)
                    .frame(maxWidth: 640)
                } //: VSTACK
                .blur(radius: showNewTaskItem ? 8.0 : 0, opaque: false)
                .animation(.easeOut(duration: 0.5), value: showNewTaskItem)
                .transition(.move(edge: .bottom))

                // MARK: - NEW TASK ITEM
                
                if showNewTaskItem {
                    BlankView(
                        backgroundColor: isDarkMode ? .black : .gray,
                        backgroundOpacity: isDarkMode ? 0.3 : 0.5)
                        .onTapGesture {
                            withAnimation {
                                showNewTaskItem = false
                            }
                        }
                    NewTaskItemView(isShowing: $showNewTaskItem)
                }
            }
            .navigationTitle("Daily Tasks")
            .navigationBarTitleDisplayMode(.large)
            .toolbar(.hidden )
            .background(
                BackgroundImageView()
                    .blur(radius: showNewTaskItem ? 8.0 : 0, opaque: false)
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
