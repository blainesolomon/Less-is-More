//
//  ContentView.swift
//  Less is More
//
//  Created by Blaine on 5/9/22.
//

import SwiftUI
import CoreData
import CloudKitSyncMonitor

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject private var syncMonitor = SyncMonitor.shared

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    @State private var showingAddItemView = false

    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(items) {
                        ItemView(item: $0)
                    }
                    .onDelete(perform: deleteItems)
                }
                .toolbar {
                    ToolbarItem {
                        Button {
                            showingAddItemView = true
                        } label: {
                            Image(systemName: "plus")
                                .imageScale(.large)
                        }
                    }
                }
                .navigationTitle("Less is More")
                .sheet(isPresented: $showingAddItemView) {
                    AddItemView()
                }
                
                HStack {
                    Spacer()
                    VStack {
                        Spacer()

                        Image(systemName: syncMonitor.syncStateSummary.symbolName)
                            .foregroundColor(syncMonitor.syncStateSummary.symbolColor)
                            .padding()
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            try? viewContext.save()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
