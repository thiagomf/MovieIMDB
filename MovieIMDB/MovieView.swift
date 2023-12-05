//
//  MovieView.swift
//  MovieIMDB
//
//  Created by Thiago M Faria on 05/12/23.
//

import SwiftUI

struct MovieView: View {
    
    let movie: Movie?
    @Environment(\.dismiss) var dismiss
    
    init(movie: Movie? = nil) {
        self.movie = movie
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Movie: " + String(movie?.title ?? "No title found"))
                Text("Description: " +  String(movie?.overview ?? "No overview found"))
            }
            .navigationTitle(movie?.title ?? "No title found")
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        dismiss()
                    }) {
                        Label("Favorite", systemImage: "arrow.left.circle")
                    }
                }
            }
            Spacer()
        }
    }
}

#Preview {
    MovieView()
}
