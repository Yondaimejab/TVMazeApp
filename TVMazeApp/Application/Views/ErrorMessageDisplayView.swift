//
//  ErrorMessageDisplayView.swift
//  TVMazeApp
//
//  Created by Joel Alcantara on 15/3/25.
//

import SwiftUI

struct ErrorMessageDisplayView: View {
    var title: String = "Something went wrong"
    var description: String = "We are having challenges completing this request"
    
    @Binding var shouldDisplayError: Bool
    
    var body: some View {
        ZStack {
            Color.clear
                .ignoresSafeArea()
            VStack {
                Spacer()
                VStack {
                    Image(systemName: "x.circle.fill")
                        .resizable()
                        .frame(width: 48, height: 48)
                        .foregroundStyle(Color.red)
                        .padding(.top)
                    Text(title)
                        .font(.title2)
                        .fontWeight(.semibold)
                    Text(description)
                        .font(.subheadline)
                        .fontWeight(.regular)
                        .padding(.bottom)
                    Button(action: {
                        shouldDisplayError = false
                    }, label: {
                        HStack {
                            Spacer()
                            Text("Volver a intentar")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundStyle(Color.white)
                            Spacer()
                        }
                        .padding()
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .padding()
                    })
                }
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .background(Color.clear)
            .padding(.horizontal)
        }
        .background(Color.black.opacity(0.75))
    }
}

#Preview {
    ErrorMessageDisplayView(shouldDisplayError: .constant(true))
}
