//
//  ShowPreviewListView.swift
//  TVMazeApp
//
//  Created by Joel Alcantara on 15/3/25.
//

import SwiftUI

struct ShowPreviewListView: View {
    @Binding var showPreviews: [ShowPreview]
    @Binding var isFetchingContent: Bool
    var action: (() -> Void)?
    @State private var selectedItemIdentifier: Int?
    @State private var shouldNavigateToItem = false
    
    var body: some View {
        if showPreviews.isEmpty {
            EmptyStateView(title: "No Results for your search")
        } else {
            List(showPreviews, id: \.id) { item in
                ShowPreviewItemView(item: item)
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    .onTapGesture {
                        selectedItemIdentifier = item.id
                        shouldNavigateToItem = true
                    }
                    .onAppear {
                        guard !isFetchingContent else { return }
                        guard item == showPreviews.last else { return }
                        action?()
                    }
            }
            .listStyle(.plain)
            .listSectionSeparatorTint(Color.clear)
            .scrollContentBackground(.hidden)
            .navigationDestination(isPresented: $shouldNavigateToItem, destination: {
                if let selectedItemIdentifier {
                    ShowView(showIdentifier: selectedItemIdentifier)
                }
            })
        }
    }
}
