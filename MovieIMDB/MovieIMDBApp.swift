//
//  MovieIMDBApp.swift
//  MovieIMDB
//
//  Created by Thiago M Faria on 30/11/23.
//

import SwiftUI

@main
struct MovieIMDBApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                
                MovieListView().environmentObject(MovieModel(movieService: MoviesService()))
                    .tabItem { Label("Movies", systemImage: "movieclapper") }
                
                WannaSeeView().tabItem { Label("Favorites", systemImage: "heart") }
                
            }
        }
    }
}
