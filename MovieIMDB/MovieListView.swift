//
//  MovieListView.swift
//  MovieIMDB
//
//  Created by Thiago M Faria on 05/12/23.
//

import SwiftUI

struct MovieListView: View {
    
    @EnvironmentObject private var model: MovieModel
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(model.movies, id: \.id) { movies in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(movies.title)
                            Text(movies.overview)
                        }
                        Spacer()
                    }
                }
            }
        }.task {
            await model.getAllMovies()
        }
    }
}

#Preview {
    MovieListView()
}
