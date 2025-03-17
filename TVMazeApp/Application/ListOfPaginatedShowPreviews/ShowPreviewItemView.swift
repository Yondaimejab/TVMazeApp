//
//  ShowPreviewItemView.swift
//  TVMazeApp
//
//  Created by Joel Alcantara on 15/3/25.
//

import SwiftUI

struct ShowPreviewItemView: View {
    var item: ShowPreview
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(item.name)
                .font(.title)
                .fontWeight(.semibold)
            HStack {
                if let url = URL(string: item.imageUrl) {
                    AsyncImage(url: url)
                        .frame(height: 150)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                Text(item.summary)
                    .font(.headline)
                    .fontWeight(.regular)
                    .multilineTextAlignment(.leading)
                    .frame(maxHeight: 150)
                Spacer()
            }
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
