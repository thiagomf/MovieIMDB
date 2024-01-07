//
//  CarouselUIView.swift
//  MovieIMDB
//
//  Created by Thiago M Faria on 22/12/23.
//

import SwiftUI

struct CarouselUIView: View {
    
    @EnvironmentObject private var model: MovieModel
    
    @State private var showPagingControl: Bool = true
    @State private var disablePagingInteraction: Bool = false
    @State private var pagingSpacing: CGFloat = 20
    @State private var titleScrollSpeed: CGFloat = 0.6
    @State private var stretchContent: Bool = true
    
    var body: some View {
        
        CarouselView(showPagingControll: showPagingControl,
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
        .task {
            await model.getTrendings()
        }
    }
}

struct CarouselView<Content: View, TitleContent: View, Movie: RandomAccessCollection>: View where Movie: MutableCollection, Movie.Element: Identifiable {
    
    var showsIndicator: ScrollIndicatorVisibility = .hidden
    var showPagingControll: Bool = true
    var disablePagingInteraction: Bool = false
    var titleScrollSpeed: CGFloat = 0.6
    var pagingControlSpacing: CGFloat = 20
    var spacing: CGFloat = 10
    
    @Binding var data: Movie
    @ViewBuilder var content: (Binding<Movie.Element>) -> Content
    @ViewBuilder var titleContent: (Binding<Movie.Element>) -> TitleContent
    
    @State private var activeID: Int?
    
    var body: some View {
        VStack(spacing: pagingControlSpacing) {
            ScrollView(.horizontal) {
                HStack(spacing: spacing) {
                    ForEach($data) { item in
                        ZStack {
                            content(item).overlay(alignment: .bottomTrailing) {
                                titleContent(item)
                                    .frame(maxWidth: .infinity)
                                    .visualEffect { content, geometryProxy in
                                        content.offset(x: scrollOffset(geometryProxy))
                                    }
                            }
                        }
                        .containerRelativeFrame(.horizontal)
                    }
                }
                .scrollTargetLayout()
            }
            .scrollIndicators(showsIndicator)
            .scrollTargetBehavior(.viewAligned)
            .scrollPosition(id: $activeID)
            
            if showPagingControll {
                PagingControl(numberOfPages: data.count, activePage: activePage) { value in
                    if let index = value as? Movie.Index, data.indices.contains(index) {
                        if let id = data[index].id as? Int {
                            withAnimation(.snappy(duration: 0.35, extraBounce: 0)) {
                                activeID = id
                            }
                        }
                    }
                }
                .disabled(disablePagingInteraction)
            }
        }
    }
    
    var activePage: Int {
        
        if let index = data.firstIndex(where: { $0.id as? Int == activeID}) as? Int {
            return index
        }
        
        return 0
    }
    
    func scrollOffset(_ proxy: GeometryProxy) -> CGFloat {
        let minX = proxy.bounds(of: .scrollView)?.minX ?? 0
        return -minX * min(titleScrollSpeed, 1)
    }
}

struct PagingControl: UIViewRepresentable {
    
    var numberOfPages: Int
    var activePage: Int
    var onPageChange: (Int) -> ()
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(onPageChange: onPageChange)
    }
    
    func makeUIView(context: Context) -> UIPageControl {
        let view = UIPageControl()
        view.currentPage = activePage
        view.numberOfPages = numberOfPages
        view.backgroundStyle = .prominent
        view.currentPageIndicatorTintColor = UIColor(Color.primary)
        view.pageIndicatorTintColor = UIColor.placeholderText
        view.addTarget(context.coordinator, action: #selector(Coordinator.onPageUpdate(control:)), for: .valueChanged)
        return view
    }
    
    func updateUIView(_ uiView: UIPageControl, context: Context) {
        uiView.numberOfPages = numberOfPages
        uiView.currentPage = activePage
    }
    
    class Coordinator: NSObject {
        var onPageChange: (Int) -> ()
        init(onPageChange: @escaping(Int)-> Void) {
            self.onPageChange = onPageChange
        }
        
        @objc
        func onPageUpdate(control: UIPageControl) {
            onPageChange(control.currentPage)
        }
    }
}
