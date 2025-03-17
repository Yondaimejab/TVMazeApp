//
//  SpinnerView.swift
//  TVMazeApp
//
//  Created by Joel Alcantara on 15/3/25.
//

import SwiftUI

struct SpinnerView: View {
    @State private var rotation: Double = 0
    
    var body: some View {
        ZStack {
            Color.clear
                .ignoresSafeArea()
            Circle()
                .trim(from: 0.55, to: 1)
                .stroke(lineWidth: 5)
                .fill(Color.red)
                .frame(width: 50, height: 50)
                .rotationEffect(Angle(degrees: rotation))
                .onAppear {
                    withAnimation(Animation.linear(duration: 1)
                        .repeatForever(autoreverses: false)) {
                            rotation = 360
                        }
                }
            Circle()
                .trim(from: 0.05, to: 0.50)
                .stroke(lineWidth: 5)
                .fill(Color.blue)
                .frame(width: 50, height: 50)
                .rotationEffect(Angle(degrees: rotation))
                .onAppear {
                    withAnimation(Animation.linear(duration: 1)
                        .repeatForever(autoreverses: false)) {
                            rotation = 360
                        }
                }
        }
        .background(Color.black.opacity(0.75))
    }
}

#Preview {
    SpinnerView()
}
