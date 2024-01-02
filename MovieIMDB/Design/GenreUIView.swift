//
//  GenreUIView.swift
//  MovieIMDB
//
//  Created by Thiago M Faria on 22/12/23.
//

import SwiftUI

enum Suit: String {
    case Action = "Action"
    case Adventure = "Adventure"
    case Animation = "Animation"
    case Comedy = "Comedy"
    case Crime = "Crime"
    case Documentary = "Documentary"
    case Drama = "Drama"
    case Family = "Family"
    case Fantasy = "Fantasy"
    case History = "History"
    case Horror = "Horror"
    case Music = "Music"
    case Mystery = "Mystery"
    case Romance = "Romance"
    case Scify = "Science Fiction"
    case TV = "Tv Movie"
    case Thriller = "Thriller"
    case War = "War"
    case Western = "Western"
}

struct GenreUIView: View {
    
    @EnvironmentObject private var model: MovieModel
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 10) {
                ForEach(model.genres, id: \.id) { genre in
                    BoxView(genero: genre.name)
                }
            }.padding([.leading, .trailing], 5)
            .padding([.top, .bottom], 10)
        }.scrollIndicators(.hidden)
        .overlay(content: {
            if model.genres.isEmpty {
                ProgressView().frame(width: 250)
            }
        })
        .task {
            await model.getGenre()
        }
    }
}

struct BoxView: View {
    
    @State var genero: String
    
    var body: some View {
        
        Button(action: {
                print("sign up bin tapped \(genero)")
            }) {
                Text(genero)
                    .frame(minWidth: 100, maxWidth: .infinity)
                    .font(.system(size: 18))
                    .padding()
                    .foregroundColor(.black)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.black, lineWidth: 2)
                )
            }
            .background(Color.white)
            
    }
}
