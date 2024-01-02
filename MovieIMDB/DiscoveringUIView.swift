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
        VStack{
            CarouselUIView(showPagingControll: showPagingControl,
                            disablePagingInteraction: disablePagingInteraction,
                            titleScrollSpeed: titleScrollSpeed,
                            pagingControlSpacing: pagingSpacing,
                            data: $model.trendings) { $item in
                RoundedRectangle(cornerRadius: 15)
                    .fill(.yellow)
                    .frame(width: stretchContent ? nil : 150,
                           height: stretchContent ? 320 : 120)
            } titleContent: { $item in
                VStack(spacing: 5) {
                    Text(item.title)
                        .font(.largeTitle.bold())
                    Text(item.originalTitle)
                        .foregroundStyle(.gray)
                        .multilineTextAlignment(.center)
                        .frame(height: 45)
                }.padding(.bottom, 35)
            }
            .safeAreaPadding([.horizontal, .top], 35)
        }.task {
            await model.getTrendings()
        }
    }
}

#Preview {
    DiscoveringUIView()
}
