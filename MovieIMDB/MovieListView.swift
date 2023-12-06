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
    
    var body: some View {
        
        NavigationStack {
            List {
                ForEach(model.movies) { movie in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(movie.title)
                            Text(movie.overview)
                        }
                        Spacer()
                    }.onTapGesture {
                        clickAction = .goToView(movie)
                    }.fullScreenCover(isPresented: $isPresented) {
                        WannaSeeView()
                    }
                }
            }.navigationTitle("WannaSee")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        self.isPresented.toggle()
                    }) {
                        Label("Favorite", systemImage: "arrow.left.circle")
                    }
                }
            }
            .task {
                await model.getAllMovies()
            }
        }
        .sheet(item: $clickAction, content: { click in
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
