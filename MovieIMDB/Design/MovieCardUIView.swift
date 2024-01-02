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
                    AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(String(describing: movie.posterPath ?? ""))"),
                               content: { image in
                        image.resizable().scaledToFit()
                    }, placeholder: {
                        ProgressView()
                    }).frame(height:200).clipShape(RoundedRectangle(cornerRadius: 20.0))
                    
                    StarsUIView(rating: movie.voteAverage/2, maxRating: 5).padding().frame(height: 50)
                }.padding()
                
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
                }.multilineTextAlignment(.leading).padding([.top, .bottom, .trailing])
            }
            
        }.frame(height: 280)
    }
}

#Preview {
    MovieCardUIView(movie: .mock())
}
