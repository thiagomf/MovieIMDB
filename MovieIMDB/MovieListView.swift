//
//  MovieListView.swift
//  MovieIMDB
//
//  Created by Thiago M Faria on 05/12/23.
//

import SwiftUI

enum Actions: Identifiable {
    
    case goToView(Movie)
    
    var id: Int {
        switch self {
        case .goToView(_):
            return 1
        }
    }
}

struct MovieListView: View {
    
    @EnvironmentObject private var model: MovieModel
    @State private var clickAction: Actions?
    @State private var isPresented = false
    @State private var page = 0
    
    var body: some View {
        
        NavigationStack {
            ScrollView {
                ForEach(model.movies) { movie in
                    HStack {
                        MovieCardUIView(movie: movie).padding(2)
                    }.onTapGesture {
                        clickAction = .goToView(movie)
                    }.fullScreenCover(isPresented: $isPresented) {
                        WannaSeeView()
                    }
                }
            }.overlay(content: {
                if model.movies.isEmpty {
                    ProgressView("Carregando...").frame(width: 250)
                }
            })
            .navigationTitle("WannaSee")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            self.isPresented.toggle()
                        }) {
                            Label("Favorite", systemImage: "arrow.left.circle")
                        }
                    }
                }.task {
                    await model.getBestMovies(page: 1)
                }
        }.sheet(item: $clickAction, onDismiss: {
            
            model.selected = nil
            
        }, content: { click in
            switch click {
            case .goToView(let movie):
                MovieView(movieSelected: movie)
            }
        })
    }
}

#Preview {
    MovieListView().environmentObject(MovieModel(movieService: MoviesService()))
}
