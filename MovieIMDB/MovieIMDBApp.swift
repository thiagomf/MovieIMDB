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
                DiscoveringUIView().environmentObject(MovieModel(movieService: MoviesService()))
                    .tabItem { Label("Discovery", systemImage: "popcorn") }
                
                MovieListView().environmentObject(MovieModel(movieService: MoviesService()))
                    .tabItem { Label("Movies", systemImage: "magnifyingglass") }
                
                WannaSeeView()
                    .tabItem { Label("Favorites", systemImage: "heart") }
                
            }
        }
    }
}
