//
//  TrendingsUIView.swift
//  MovieIMDB
//
//  Created by Thiago M Faria on 02/01/24.
//

import SwiftUI

struct DiscoveryUIView: View {
    
    @EnvironmentObject private var model: MovieModel
    
    var body: some View {
        VStack {
            ForEach(model.discovering) { discover in
                MovieCardUIView(movie: discover).padding(5)
            }
        }.task {
            await model.getDiscovering()
        }
    }
}

#Preview {
    DiscoveryUIView().environmentObject(MovieModel(movieService: MoviesService()))
}
