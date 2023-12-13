//
//  MovieCardUIView.swift
//  MovieIMDB
//
//  Created by Thiago M Faria on 11/12/23.
//

import SwiftUI

struct MovieCardUIView: View {
    
    let movie: Movie
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20, style: .continuous).fill(.black)
            HStack {
                
                VStack {
                    AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath)"),
                               content: { image in
                        image.resizable()
                        
                    }, placeholder: {
                        ProgressView()
                    }).frame(width:150, height:200).clipShape(RoundedRectangle(cornerRadius: 20.0)).padding(5)
                    
                    StarsUIView(rating: movie.voteAverage/2, maxRating: 5).padding().frame(height: 50)
                }
                
                VStack(alignment: .leading) {
                    Text(movie.title)
                        .font(.headline)
                        .foregroundColor(.gray)
                    HStack {
                        Text("Release:")
                            .font(.footnote)
                            .foregroundColor(.gray)
                        Text(movie.releaseDate.showBRData())
                            .foregroundColor(.gray)
                            .font(.footnote)
                    }
                    Text(movie.overview.maxLength())
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Spacer()
                }.multilineTextAlignment(.leading).padding()
            }
        }.frame(width: 390, height: 300)
    }
}

#Preview {
    MovieCardUIView(movie: .mock())
}
