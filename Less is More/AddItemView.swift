//
//  AddItemView.swift
//  Less is More
//
//  Created by Blaine on 5/9/22.
//

import SwiftUI

struct AddItemView: View {
    @State private var text = ""
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss
    @FocusState var focused: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Type Title here. Tap Done to save.", text: $text)
                    .padding(.horizontal)
                    .focused($focused)
                    .onSubmit {
                        addItem()
                        dismiss()
                    }
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .imageScale(.large)
                    }
                }
            }
            .submitLabel(.done)
            .navigationTitle("Add Item")
            .task {
                try? await Task.sleep(nanoseconds: UInt64(1_000_000_000 * 0.5))
                focused = true
            }
        }
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.title = text.isEmpty ? "Something" : text

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView()
    }
}
