//
//  WannaSeeView.swift
//  MovieIMDB
//
//  Created by Thiago M Faria on 05/12/23.
//

import SwiftUI

struct WannaSeeView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        NavigationStack {
            VStack {
                Text("Future Favorites movies")
            }.navigationTitle("No title found")
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Label("Favorite", systemImage: "arrow.left.circle")
                    }
                }
            }
        }
    }
}

#Preview {
    WannaSeeView()
}
