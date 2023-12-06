//
//  MovieView.swift
//  MovieIMDB
//
//  Created by Thiago M Faria on 05/12/23.
//

import SwiftUI

struct MovieView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var model: MovieModel
    let movieSelected: Movie?
    
    init(movieSelected: Movie? = nil) {
        self.movieSelected = movieSelected
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                
                Text("Movie: " + String(movieSelected?.title ?? "No title found"))
                Text("Description: " +  String(movieSelected?.overview ?? "No overview found"))
                if(model.selected == nil) {
                    Text("Entrou no carregando")
                    ProgressView("Carregando...")
                } else {
                    Text("Adult: " + String(model.selected?.adult ?? true))
                    Text("Language: " + String(model.selected?.originalLanguage ?? ""))
                    Text("Popularity" + String(model.selected?.popularity ?? 0.0))
                }
            }
            .navigationTitle(movieSelected?.title ?? "No title found")
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                       
                    }) {
                        Label("Favorite", systemImage: "arrow.left.circle")
                    }
                }
            }.task {
                await model.getIDMovie(id: self.movieSelected?.id ?? 0)
            }
            Spacer()
        }
    }
}

#Preview {
    MovieView()
}
