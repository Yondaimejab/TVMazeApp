//
//  EmptyStateView.swift
//  TVMazeApp
//
//  Created by Joel Alcantara on 15/3/25.
//

import SwiftUI

struct EmptyStateView: View {
    var title: String
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                VStack {
                    Image(systemName: "exclamationmark.magnifyingglass")
                        .resizable()
                        .frame(width: 48, height: 48)
                        .foregroundStyle(Color.white)
                    Text(title)
                        .foregroundStyle(Color.white)
                        .font(.largeTitle)
                }
                Spacer()
            }
            Spacer()
        }
    }
}

#Preview {
    EmptyStateView(title: "No Results for your search")
}
