//
//  ItemView.swift
//  Less is More
//
//  Created by Blaine on 5/9/22.
//

import SwiftUI

struct ItemView: View {
    let item: Item
    @State private var showingConfirmCompleteItem = false
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        Button {
            showingConfirmCompleteItem = true
        } label: {
            Text(item.title ?? "Something")
                .font(.title)
        }
        .confirmationDialog("Complete?", isPresented: $showingConfirmCompleteItem, titleVisibility: .hidden) {
            Button(role: .destructive) {
                deleteItem()
            } label: {
                Text("Mark as Complete")
            }
        }
    }
    
    private func deleteItem() {
        withAnimation {
            viewContext.delete(item)
            try? viewContext.save()
        }
    }
}
