//
//  DiscoveringUIView.swift
//  MovieIMDB
//
//  Created by Thiago M Faria on 22/12/23.
//

import SwiftUI

struct DiscoveringUIView: View {
    
    @EnvironmentObject private var model: MovieModel
    
    @State private var showPagingControl: Bool = true
    @State private var disablePagingInteraction: Bool = false
    @State private var pagingSpacing: CGFloat = 20
    @State private var titleScrollSpeed: CGFloat = 0.6
    @State private var stretchContent: Bool = true
    
    var body: some View {
        NavigationStack {
            ScrollView {
                CarouselUIView(showPagingControll: showPagingControl,
                               disablePagingInteraction: disablePagingInteraction,
                               titleScrollSpeed: titleScrollSpeed,
                               pagingControlSpacing: pagingSpacing,
                               data: $model.trendings) { $item in
                    
                    AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(String(describing: item.posterPath ?? ""))"),
                               content: { image in
                        image.resizable().scaledToFill()
                    }, placeholder: {
                        ProgressView()
                    }).frame(width: stretchContent ? nil : 150,
                             height: stretchContent ? 320 : 120)
                    .clipShape(RoundedRectangle(cornerRadius: 20.0))
                    
                } titleContent: { $item in
                    VStack(alignment: .leading, spacing: 0) {
                        Text(item.title)
                            .padding(2)
                            .font(.title2.bold())
                            .background(.white)
                            .opacity(0.8)
                        Text(item.overview)
                            .padding(2)
                            .foregroundStyle(.black)
                            .background(.white)
                            .opacity(0.8)
                            .multilineTextAlignment(.leading)
                            .lineLimit(3)
                    }.padding([.leading, .trailing, .bottom], 10)
                }
                .safeAreaPadding([.horizontal, .top], 5)
                
                GenreUIView()
                
                Text("Discovery in 2024").font(.title.bold()).frame(maxWidth: .infinity, alignment: .leading).padding()
                
                DiscoveryUIView()
                
            }.task {
                await model.getTrendings()
            }.navigationTitle("Wanna see")
        }
        
    }
}

#Preview {
    DiscoveringUIView()
}
