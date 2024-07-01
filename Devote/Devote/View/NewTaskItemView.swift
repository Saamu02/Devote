//
//  NewTaskItemView.swift
//  Devote
//
//  Created by Ussama Irfan on 01/07/2024.
//

import SwiftUI

struct NewTaskItemView: View {
    
    // MARK: - PROPERTY
    @AppStorage("isDarkMode") private var isDarkMode = false

    @Environment(\.managedObjectContext) private var viewContext
    @State private var task: String = ""
    @Binding var isShowing: Bool

    private var isButtonDisabled: Bool {
        task.isEmpty
    }
    
    @FocusState private var taskTextFieldFocused: Bool
    
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
            isShowing = false
        }
    }
    
    // MARK: - BODy
    var body: some View {
        
        VStack {
            Spacer()
            
            VStack(spacing: 16) {
                
                TextField("New Task", text: $task)
                    .foregroundStyle(.pink)
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .padding()
                    .background(
                        isDarkMode ?                         Color(.tertiarySystemBackground) : Color(.secondarySystemBackground)

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
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                    Spacer()
                })
                .disabled(isButtonDisabled)
                .padding()
                .foregroundStyle(.white)
                .background(isButtonDisabled ? Color.blue : Color.pink)
                .clipShape(
                    RoundedRectangle(cornerRadius: 10)
                )
                
            } //: VSTACK
            .padding(.horizontal)
            .padding(.vertical, 20)
            .background(isDarkMode ? Color(.secondarySystemBackground) : Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(color: .black.opacity(0.65), radius: 24)
            .frame(maxWidth: 640)
        }//: VSTACK
        .padding()
    }
}

#Preview {
    NewTaskItemView(isShowing: .constant(true))
        .background(Color.gray)
}
