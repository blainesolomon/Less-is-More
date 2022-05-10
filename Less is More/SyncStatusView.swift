//
//  SyncStatusView.swift
//  Less is More
//
//  Created by Blaine on 5/9/22.
//

import SwiftUI
import CloudKitSyncMonitor

struct SyncStatusView: View {
    @available(iOS 14.0, *)
    @ObservedObject var syncMonitor = SyncMonitor.shared
    
    var body: some View {
        Image(systemName: syncMonitor.syncStateSummary.symbolName)
            .foregroundColor(syncMonitor.syncStateSummary.symbolColor)
        
    }
}

struct SyncStatusView_Previews: PreviewProvider {
    static var previews: some View {
        SyncStatusView()
    }
}
